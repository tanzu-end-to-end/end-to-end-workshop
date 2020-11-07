# Run the Carvel install in a seperate stage because of perl dependency
FROM ubuntu:bionic as carvel
RUN apt-get update && apt-get install -y bash curl perl && apt-get clean 
RUN curl -L https://k14s.io/install.sh | bash
# Download and run Helm install script in it's own layer
FROM ubuntu:bionic as bionic
RUN apt-get update && apt-get install -y bash curl && apt-get clean
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 && \
  chmod 700 get_helm.sh && \
  ./get_helm.sh
# # stuff from 
# FROM ubuntu:bionic
# RUN apt-get update && apt-get install -y bash curl && apt-get clean
# Assemble the final image
FROM quay.io/eduk8s/base-environment:master
#COPY --chown=1001:0 . /home/eduk8s/
#RUN mv /home/eduk8s/workshop /opt/workshop
#RUN fix-permissions /home/eduk8s
# Carvel
COPY --from=carvel /usr/local/bin/ytt /usr/local/bin/ytt
COPY --from=carvel /usr/local/bin/kapp /usr/local/bin/kapp
COPY --from=carvel /usr/local/bin/kbld /usr/local/bin/kbld
COPY --from=carvel /usr/local/bin/kwt /usr/local/bin/kwt
COPY --from=carvel /usr/local/bin/imgpkg /usr/local/bin/imgpkg
COPY --from=carvel /usr/local/bin/vendir /usr/local/bin/vendir
#conftest 
COPY --from=instrumenta/conftest /conftest /usr/local/bin/conftest
# Kubectl ,  get it 
COPY --from=bitnami/kubectl /opt/bitnami/kubectl/bin/kubectl /usr/local/bin/kubectl
# Helm
COPY --from=bionic /usr/local/bin/helm /usr/local/bin/helm
# YQ & JQ
COPY --from=mikefarah/yq /usr/bin/yq /usr/local/bin/yq
COPY --from=stedolan/jq /usr/local/bin/jq /usr/local/bin/jq
# Docker CLI
COPY --from=docker /usr/local/bin/docker /usr/local/bin/docker
# All the direct Downloads need to run as root as  they are going to /usr/local/bin
USER root
# TMC
RUN curl -L -o /usr/local/bin/tmc $(curl -s https://tanzupaorg.tmc.cloud.vmware.com/v1alpha/system/binaries | jq -r 'getpath(["versions",.latestVersion]).linuxX64') && \
  chmod 755 /usr/local/bin/tmc
# Policy Tools
RUN curl -L -o /usr/local/bin/opa https://openpolicyagent.org/downloads/latest/opa_linux_amd64 
RUN chmod 755 /usr/local/bin/opa
# Velero
RUN VELERO_DOWNLOAD_URL=$(curl -s https://api.github.com/repos/vmware-tanzu/velero/releases/latest | jq -r '.assets[] | select ( .name | contains("linux-amd64") ) .browser_download_url') && \
  curl -fL --output /tmp/velero.tar.gz ${VELERO_DOWNLOAD_URL} && \
  tar -xzf /tmp/velero.tar.gz -C /usr/local/bin --strip-components=1 --wildcards velero-*-linux-amd64/velero && \
  rm /tmp/velero.tar.gz
# TAC
RUN curl -fL --output /tmp/tac.tar.gz https://downloads.bitnami.com/tac/tac-cli_beta-e936104-linux_amd64.tar.gz && \
  tar -xzf /tmp/tac.tar.gz -C /usr/local/bin tac && \
  rm /tmp/tac.tar.gz
# TBS
# TODO :  Change the logic to identify the latest anbd download  or move to pivnet 
RUN curl -L -o /usr/local/bin/kp  https://github.com/vmware-tanzu/kpack-cli/releases/download/v0.1.3/kp-linux-0.1.3  && \
  chmod 755 /usr/local/bin/kp
# COPY kp-linux-0.1.1 /usr/local/bin/kp
RUN chmod 755 /usr/local/bin/kp
RUN  curl -sSL "https://github.com/buildpacks/pack/releases/download/v0.14.2/pack-v0.14.2-linux.tgz" | sudo tar -C /usr/local/bin/ --no-same-owner -xzv pack
RUN curl -sSL "https://github.com/concourse/concourse/releases/download/v6.7.1/fly-6.7.1-linux-amd64.tgz" |sudo tar -C /usr/local/bin/ --no-same-owner -xzv fly
USER 1001