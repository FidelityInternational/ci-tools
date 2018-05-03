FROM ubuntu

RUN apt-get update \
  && apt-get install -y unzip openssl curl wget vim \
  && apt-get clean

RUN curl -L https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 -o /usr/local/bin/jq \
  && chmod +x /usr/local/bin/jq

RUN curl -L https://github.com/mikefarah/yq/releases/download/1.14.1/yq_linux_amd64 -o /usr/local/bin/yaml  \
  && chmod +x /usr/local/bin/yaml \
  && ln -s /usr/local/bin/yaml /usr/local/bin/yq

RUN curl -L https://github.com/cloudfoundry-incubator/credhub-cli/releases/download/1.7.5/credhub-linux-1.7.5.tgz -o credhub-linux-1.7.5.tgz \
  && tar xvf credhub-linux-1.7.5.tgz -C /usr/local/bin/ \
  && chmod +x /usr/local/bin/credhub \
  && rm credhub-linux-1.7.5.tgz

RUN curl -L https://github.com/pivotalservices/cf-mgmt/releases/download/v0.0.87/cf-mgmt-linux -o /usr/local/bin/cf-mgmt \
  && chmod +x /usr/local/bin/cf-mgmt

RUN curl -L https://github.com/pivotalservices/cf-mgmt/releases/download/v0.0.87/cf-mgmt-config-linux -o /usr/local/bin/cf-mgmt-config \
  && chmod +x /usr/local/bin/cf-mgmt-config

COPY verify_image.sh /tmp/verify_image.sh
RUN /tmp/verify_image.sh
