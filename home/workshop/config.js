const { exec } = require("child_process");


function initialize(workshop) {
  workshop.load_workshop();

  exec("yq r ~/.kube/config 'users(name==eduk8s).user.token'", (error, stdout, stderr) => {
    output = ""
    if (error) {
        output += error.message + "\n";
    }
    if (stderr) {
        output += stderr + "\n";
    }
    output += stdout;
    workshop.data_variable('user_token', output);
  });
}

exports.default = initialize;

module.exports = exports.default;