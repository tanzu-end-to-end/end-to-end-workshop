set -x

ytt template -f ../../base -f $1 --ignore-unknown-comments | kapp deploy -n default -a workshop -f- --diff-changes --yes
