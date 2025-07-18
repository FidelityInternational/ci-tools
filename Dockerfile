FROM ubuntu:jammy

## Have to use this due to default interactive tzdata config
ARG DEBIAN_FRONTEND=noninteractive 

ENV BOSH_VERSION="7.9.7"
ENV CF_MGMT_VERSION="1.0.106"
ENV CREDHUB_VERSION "2.9.47"
ENV YQ_VERSION="4.26.1"

RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y jq unzip openssl curl wget vim ruby sshpass build-essential git rsync tzdata dnsutils awscli \
  && apt-get clean

RUN curl -fL "https://github.com/mikefarah/yq/releases/download/v${YQ_VERSION}/yq_linux_amd64" -o /usr/local/bin/yq && chmod +x /usr/local/bin/yq

RUN curl -fL "https://github.com/cloudfoundry/credhub-cli/releases/download/${CREDHUB_VERSION}/credhub-linux-amd64-${CREDHUB_VERSION}.tgz" | tar -zx -C /usr/local/bin && \
chmod +x /usr/local/bin/credhub

RUN curl -fL "https://github.com/vmware-tanzu-labs/cf-mgmt/releases/download/v${CF_MGMT_VERSION}/cf-mgmt-linux" -o /usr/local/bin/cf-mgmt && chmod +x /usr/local/bin/cf-mgmt

RUN curl -fL "https://github.com/vmware-tanzu-labs/cf-mgmt/releases/download/v${CF_MGMT_VERSION}/cf-mgmt-config-linux" -o /usr/local/bin/cf-mgmt-config && chmod +x /usr/local/bin/cf-mgmt-config

RUN curl -fL "https://github.com/cloudfoundry/bosh-cli/releases/download/v${BOSH_VERSION}/bosh-cli-${BOSH_VERSION}-linux-amd64" -o /usr/local/bin/bosh && \
  chmod +x /usr/local/bin/bosh

COPY verify_image.sh /tmp/verify_image.sh
RUN /tmp/verify_image.sh
