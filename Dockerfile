FROM ubuntu

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y unzip openssl && apt-get clean

RUN curl -L https://github.com/mikefarah/yq/releases/download/1.14.1/yq_linux_amd64 -o yaml && chmod +x yaml && mv yaml /usr/local/bin/yaml && ln -s /usr/local/bin/yaml /usr/local/bin/yq

RUN curl -L https://github.com/cloudfoundry-incubator/credhub-cli/releases/download/1.7.5/credhub-linux-1.7.5.tgz -o credhub-linux-1.7.5.tgz && tar xvf credhub-linux-1.7.5.tgz -C /usr/local/bin/ && chmod +x /usr/local/bin/credhub && rm credhub-linux-1.7.5.tgz

RUN curl -L https://github.com/pivotalservices/cf-mgmt/releases/download/v0.0.87/cf-mgmt-linux -o cf-mgmt && chmod +x cf-mgmt && mv cf-mgmt /usr/local/bin/cf-mgmt

RUN curl -L https://github.com/pivotalservices/cf-mgmt/releases/download/v0.0.87/cf-mgmt-config-linux -o cf-mgmt-config && chmod +x cf-mgmt-config && mv cf-mgmt-config /usr/local/bin/cf-mgmt-config

COPY verify_image.sh /tmp/verify_image.sh
RUN /tmp/verify_image.sh && rm /tmp/verify_image.sh
