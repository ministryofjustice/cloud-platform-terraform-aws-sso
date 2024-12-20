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

    const filteredTeams = git_teams.filter((t) => t != "all-org-members");

    api.user.GithubTeam = ":" + filteredTeams.join(":") + ":";
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
      ":" + filteredTeams.join(":") + ":",
    );
  }
};
