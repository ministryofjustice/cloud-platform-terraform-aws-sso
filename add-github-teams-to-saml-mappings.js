function(user, context, callback) {
  var request = require('request');

  if(context.connection === 'github'){
    var awsAccount = configuration.AWS_ACCOUNT_ID;
    var samlProvider = configuration.AWS_SAML_PROVIDER_NAME;
    var rolePrefix = 'arn:aws:iam::' + awsAccount;
    var role = 'AccessViaGithub';
    var awsTagKey = 'GithubTeam';
    var principalTag = 'https://aws.amazon.com/SAML/Attributes/PrincipalTag:' + awsTagKey;
    var samlIdP = rolePrefix + ':saml-provider/' + samlProvider;
    // Get user's Github profile and API access key
    var github_identity = _.find(user.identities, { connection: 'github' });
    // Get list of user's Github teams
    var teams_req = {
      url: 'https://api.github.com/user/teams',
      headers: {
        'Authorization': 'token ' + github_identity.access_token,
        'User-Agent': 'request'
      }
    };
    request(teams_req, function (err, resp, body) {
      if (resp.statusCode !== 200) {
        return callback(new Error('Error retrieving teams from Github: ' + body || err));
      }
      user.awsRoleSession = user.nickname;
      user.awsTagKeys = [awsTagKey];
      var git_teams = JSON.parse(body).map(function (team) {
        if (team.organization.login === "ministryofjustice") {
          return team.slug;
        }
      });
      user.GithubTeam = ":" + git_teams.join(":") + ":";
			user.awsRole = rolePrefix + ':role/' + role + "," + samlIdP;
      context.samlConfiguration.mappings = {
          'https://aws.amazon.com/SAML/Attributes/Role': 'awsRole',
          'https://aws.amazon.com/SAML/Attributes/RoleSessionName': 'awsRoleSession',
          principalTag: awsTagKey,
      };
      return callback(null, user, context);
    
    });
  } else {
    return callback(null, user, context);
  }
}
