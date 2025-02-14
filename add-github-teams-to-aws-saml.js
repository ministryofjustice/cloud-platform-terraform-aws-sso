const axios = require('axios');

exports.onExecutePostLogin = async (event, api) => {
  if (event.connection.name === "github") {
    const samlProvider = event.secrets.AWS_SAML_PROVIDER_NAME;
    const awsAccount = event.secrets.AWS_ACCOUNT_ID;
    const filterApiKey = event.secrets.FILTER_API_KEY;
    const rolePrefix = "arn:aws:iam::" + awsAccount;
    const role = "access-via-github";
    const samlIdP = rolePrefix + ":saml-provider/" + samlProvider;
    const filterUrl = "https://github-teams-filter.apps.live.cloud-platform.service.justice.gov.uk/filter-teams"

    const git_teams = event.user.user_metadata["gh_teams"].map((t) =>
      t.replace("github:", ""),
    );

    const filteredTeams = git_teams.filter((t) => t != "all-org-members");

    const teamsString = ":" + filteredTeams.join(":") + ":";
    
    let filteredTeamsString;

    try {
      const response = await axios.post(filterUrl, 
      { teams: teamsString }, 
      {
        headers: {
          "X-API-Key": filterApiKey,
          "Content-Type": "application/json"
        }
      });

      const result = response.data;
      filteredTeamsString = result["filtered_teams"];
      
    } catch (error) {
      console.error("Error whilst calling github-teams-filter API:", error);
      filteredTeamsString = teamsString;
    }

    api.user.GithubTeam = filteredTeamsString;
    api.user.awsRoleSession = event.user.nickname;
    api.user.awsTagKeys = ["GithubTeam"];
    api.user.awsRole = rolePrefix + ":role/" + role + "," + samlIdP;

    api.samlResponse.setAttribute(
      "https://aws.amazon.com/SAML/Attributes/Role",
      rolePrefix + ":role/" + role + "," + samlIdP,
    );

    api.samlResponse.setAttribute(
      "https://aws.amazon.com/SAML/Attributes/RoleSessionName",
      event.user.nickname,
    );

    api.samlResponse.setAttribute(
      "https://aws.amazon.com/SAML/Attributes/PrincipalTag:GithubTeam",
      filteredTeamsString,
    );
  }
};