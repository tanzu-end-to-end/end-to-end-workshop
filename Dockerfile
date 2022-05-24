ARG TANZU_CLI_VERSION=v0.11.4

FROM apnex/vmw-cli as clis
ARG MYVMWAREUSER
ARG MYVMWAREPASS
ARG TANZU_CLI_VERSION
ENV VMWUSER=${MYVMWAREUSER}
ENV VMWPASS=${MYVMWAREPASS}
RUN vmw-cli ls vmware_tanzu_kubernetes_grid/1_x/PRODUCT_BINARY \
  && vmw-cli cp tanzu-cli-bundle-linux-amd64.tar.gz
WORKDIR /files
ENV HOMEDIR=/root
RUN tar xzf tanzu-cli-bundle-linux-amd64.tar.gz
RUN adduser -D -u 1001 eduk8s -g root
USER 1001
RUN /files/cli/core/${TANZU_CLI_VERSION}/tanzu-core-linux_amd64 init
RUN /files/cli/core/${TANZU_CLI_VERSION}/tanzu-core-linux_amd64 plugin sync

FROM quay.io/eduk8s/base-environment:210508.015017.4546935
#conftest 
COPY --from=harbor-repo.vmware.com/dockerhub-proxy-cache/instrumenta/conftest /conftest /usr/local/bin/conftest
# All the direct Downloads need to run as root as  they are going to /usr/local/bin
USER root
# TMC
RUN curl -L -o /usr/local/bin/tmc $(curl -s https://tanzupaorg.tmc.cloud.vmware.com/v1alpha/system/binaries | jq -r 'getpath(["versions",.latestVersion]).linuxX64') && \
  chmod 755 /usr/local/bin/tmc
# Policy Tools
RUN curl -L -o /usr/local/bin/opa https://openpolicyagent.org/downloads/latest/opa_linux_amd64 && \
  chmod 755 /usr/local/bin/opa
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
RUN curl -L -o /usr/local/bin/kp https://github.com/vmware-tanzu/kpack-cli/releases/download/v0.4.2/kp-linux-0.4.2 && \
  chmod 755 /usr/local/bin/kp
RUN curl -sSL "https://github.com/buildpacks/pack/releases/download/v0.20.0/pack-v0.20.0-linux.tgz" | sudo tar -C /usr/local/bin/ --no-same-owner -xzv pack
# Concourse
RUN curl -sSL "https://github.com/concourse/concourse/releases/download/v7.4.0/fly-7.4.0-linux-amd64.tgz" |sudo tar -C /usr/local/bin/ --no-same-owner -xzv fly
# ArgoCD
RUN ARGOCD_VERSION=$(curl --silent "https://api.github.com/repos/argoproj/argo-cd/releases/latest" | grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/') && \
  curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/download/$ARGOCD_VERSION/argocd-linux-amd64 && \
  chmod 755 /usr/local/bin/argocd
ARG TANZU_CLI_VERSION
COPY --from=clis /files/cli/core/${TANZU_CLI_VERSION}/tanzu-core-linux_amd64 /usr/local/bin/tanzu
COPY --from=clis home/eduk8s/.config/tanzu/ /home/eduk8s/.config/tanzu
COPY --from=clis home/eduk8s/.cache /home/eduk8s/.cache
COPY --from=clis home/eduk8s/.local /home/eduk8s/.local
RUN chmod 775 -R /home/eduk8s/.config /home/eduk8s/.cache /home/eduk8s/.local && chown -R eduk8s /home/eduk8s/.cache /home/eduk8s/.config /home/eduk8s/.local
USER 1001