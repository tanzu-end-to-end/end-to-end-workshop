set -x

ytt template -f ../../base -f $1 | kapp deploy -n default -a workshop -f- --diff-changes --yes
