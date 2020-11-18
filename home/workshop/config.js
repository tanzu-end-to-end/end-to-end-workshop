const fs = require('fs');
const yaml = require('js-yaml');
const { spawn } = require('child_process');

function initialize(workshop) {
  workshop.load_workshop();

  let fileContents = fs.readFileSync('/home/eduk8s/.kube/config');
  let data = yaml.safeLoad(fileContents);
  
  workshop.data_variable('user_token', data.users[0].user.token);

  let namespace = process.env['SESSION_NAMESPACE']
  kubectl = spawn('kubectl', ['-n', namespace, 'get', 'harborproject', namespace, '-o', 'jsonpath="{.status.projectid}"']);

  let kubectl_out = ""
  let kubectl_err = ""

  kubectl.stdout.on('data', (out) => {
    console.log(`stdout: ${out}`);
    kubectl_out = out;
  });
  
  kubectl.stderr.on('data', (err) => {
    console.error(`stderr: ${err}`);
    kubectl_err = err;
  });
  
  kubectl.on('close', (code) => {
    console.log(`child process exited with code ${code}`);
    if(code == 0) {
      workshop.data_variable('harbor_project_id', kubectl_out);
    }
  });
}

exports.default = initialize;

module.exports = exports.default;