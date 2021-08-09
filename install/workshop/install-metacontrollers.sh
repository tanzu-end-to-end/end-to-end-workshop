set -x

ytt --ignore-unknown-comments template -f ../../metacontroller/metacontroller -f ../../metacontroller/argocd-project-controller -f  ../../metacontroller/harbor-project-controller -f $1 | kapp deploy -n default -a metacontroller -f- --diff-changes --yes
