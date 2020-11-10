const fs = require('fs');
const yaml = require('js-yaml');

function initialize(workshop) {
  workshop.load_workshop();

  let fileContents = fs.readFileSync('/home/eduk8s/.kube/config');
  let data = yaml.safeLoad(fileContents);
  
  workshop.data_variable('user_token', data.users[0].user.token);
}

exports.default = initialize;

module.exports = exports.default;