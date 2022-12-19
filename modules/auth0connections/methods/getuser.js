/*
Requires Auth0 Global Variables to be set - https://auth0.com/docs/rules/configure-global-variables-for-rules
If testing locally (or not wanting to use Auth0 Global Variables):
const configuration = {
  "accessKeyId": "AKIAIBDT5G4M237CZSMQ",
  "secretAccessKey": "your-cognito-secret-access-key",
  "region": "eu-west-1",
  "UserPoolId": "eu-west-1_V69pvauTp"
*/

function getUser(username, callback) {
    const userParameters =  ["email", "email_verified"];
    const AWS = require('aws-sdk@2.593.0');
    AWS.config.update({ "accessKeyId": configuration.accessKeyId, "secretAccessKey": configuration.secretAccessKey, "region": configuration.region });
    const cognito = new AWS.CognitoIdentityServiceProvider();

    cognito.adminGetUser({
        UserPoolId: configuration.UserPoolId,
        Username: username
    }, (err, data) => {
        if (err) {
            console.log(err);
            if (err.code === "UserNotFoundException") return callback(null);
            else callback(err);
        }
        else {
            console.log(data);
            if (data.code === "UserNotFoundException") return callback(null);
            else {
                let profile = {
                    "user_id": data.UserAttributes.find(item=>item.Name==="sub").Value,
                    "username": data.Username,
                };
                userParameters.forEach(customParameterName => {
                    profile[customParameterName] = data.UserAttributes.find(item=>item.Name===customParameterName).Value;
                });
                return callback(null, profile);
            }
        }

    });

}