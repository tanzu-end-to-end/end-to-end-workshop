set -x

ytt template -f ../../metacontroller -f $1 | kapp deploy -n default -a metacontroller -f- --diff-changes --yes
