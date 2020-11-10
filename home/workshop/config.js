const { exec } = require("child_process");


function initialize(workshop) {
  workshop.load_workshop();

  exec("yq r ~/.kube/config 'users(name==eduk8s).user.token'", (error, stdout, stderr) => {
    if (error) {
        console.log(`error: ${error.message}`);
        return;
    }
    if (stderr) {
        console.log(`stderr: ${stderr}`);
        return;
    }
    workshop.data_variable('user_token', stdout);
  });
}

exports.default = initialize;

module.exports = exports.default;