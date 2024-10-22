exports.onExecutePostLogin = async (event, api) => {
  if (event.connection.name === "github") {
    const samlProvider = event.secrets.AWS_SAML_PROVIDER_NAME;
    const awsAccount = event.secrets.AWS_ACCOUNT_ID;
    const rolePrefix = "arn:aws:iam::" + awsAccount;
    const role = "access-via-github";
    const samlIdP = rolePrefix + ":saml-provider/" + samlProvider;

    const git_teams = event.user.user_metadata["gh_teams"].map((t) =>
      t.replace("github:", ""),
    );

    api.user.GithubTeam = ":" + git_teams.join(":") + ":";
    api.user.awsRoleSession = user.nickname;
    api.user.awsTagKeys = ["GithubTeam"];
    api.user.awsRole = rolePrefix + ":role/" + role + "," + samlIdP;

    api.samlResponse.setAttribute(
      "https://aws.amazon.com/SAML/Attributes/Role",
      rolePrefix + ":role/" + role + "," + samlIdP,
    );

    api.SamlResponse.SetAttribute(
      "https://aws.amazon.com/SAML/Attributes/RoleSessionName",
      user.nickname,
    );

    api.SamlResponse.SetAttribute(
      "https://aws.amazon.com/SAML/Attributes/PrincipalTag:GithubTeam",
      ":" + git_teams.join(":") + ":",
    );
  }
};
