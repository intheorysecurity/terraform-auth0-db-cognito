/*
Read StackOverflow article about potential window issue: https://stackoverflow.com/questions/40219518/aws-cognito-unauthenticated-login-error-window-is-not-defined-js

Requires Auth0 Global Variables to be set - https://auth0.com/docs/rules/configure-global-variables-for-rules

If testing locally (or not wanting to use Auth0 Global Variables):
const configuration = {
  "ClientId": "nzHNdG0XGS4qSaS5p0EZZesoIO2xfKQDRMgWPoce",
  "UserPoolId": "eu-west-1_V69pvauTp"
*/

function login(username, password, callback) {
    //Fetch is built-in within CIC NodeJS 18.  
    //Uncomment line below, if you are using version of NodeJS 16 or lower
    //global.fetch = require('node-fetch@2.6.0');
    var AmazonCognitoIdentity = require('amazon-cognito-identity-js@3.0.14');
    var poolData = {
        UserPoolId: configuration.UserPoolId,
        ClientId: configuration.ClientId

    };
    var userPool = new AmazonCognitoIdentity.CognitoUserPool(poolData);

    var authenticationDetails = new AmazonCognitoIdentity.AuthenticationDetails({
        Username: username,
        Password: password
    });
    var userData = {
        Username: username,
        Pool: userPool
    };
    var cognitoUser = new AmazonCognitoIdentity.CognitoUser(userData);
    cognitoUser.authenticateUser(authenticationDetails, {
        onSuccess: function (result) {
            //console.log(result);
            var idTokenPayload = result.getIdToken().payload;
            console.log(idTokenPayload);
            var profile = {
              user_id: idTokenPayload.sub,
              email: idTokenPayload.email,
              /* might want to set this to false if you're not validating email addresses */
              email_verified: true,
            };
            console.log({ result, idTokenPayload, profile });
            callback(null, profile);
        },
        onFailure: (function (err) {
            return callback(new WrongUsernameOrPasswordError(username))
        })
    });
}