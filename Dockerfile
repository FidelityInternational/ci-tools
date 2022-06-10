FROM ubuntu

## Have to use this due to default interactive tzdata config
ARG DEBIAN_FRONTEND=noninteractive 

RUN apt-get update \
  && apt-get install -y unzip openssl curl wget vim ruby sshpass build-essential git rsync tzdata dnsutils awscli \
  && apt-get clean

RUN curl -L https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 -o /usr/local/bin/jq \
  && chmod +x /usr/local/bin/jq

RUN curl -L https://github.com/mikefarah/yq/releases/download/v4.9.6/yq_linux_amd64 -o /usr/local/bin/yq \
  && chmod +x /usr/local/bin/yq

RUN curl -L https://github.com/cloudfoundry-incubator/credhub-cli/releases/download/2.9.0/credhub-linux-2.9.0.tgz -o credhub-linux-2.9.0.tgz \
  && tar xvf credhub-linux-2.9.0.tgz -C /usr/local/bin/ \
  && chmod +x /usr/local/bin/credhub \
  && rm credhub-linux-2.9.0.tgz

RUN curl -L https://github.com/vmware-tanzu-labs/cf-mgmt/releases/download/v1.0.51/cf-mgmt-linux -o /usr/local/bin/cf-mgmt \
  && chmod +x /usr/local/bin/cf-mgmt

RUN curl -L https://github.com/vmware-tanzu-labs/cf-mgmt/releases/download/v1.0.51/cf-mgmt-config-linux -o /usr/local/bin/cf-mgmt-config \
  && chmod +x /usr/local/bin/cf-mgmt-config

RUN wget https://github.com/cloudfoundry/bosh-cli/releases/download/v6.4.7/bosh-cli-6.4.7-linux-amd64 \
    && mv bosh-cli-6.4.7-linux-amd64 /usr/bin/bosh \
    && chmod +x /usr/bin/bosh

COPY verify_image.sh /tmp/verify_image.sh
RUN /tmp/verify_image.sh
