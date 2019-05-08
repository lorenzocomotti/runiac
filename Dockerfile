##Download base image ubuntu xenial
FROM ubuntu:xenial

MAINTAINER Lorenzo Comotti

##Update packages 
RUN apt -y update

## Add Kubernetes repository
RUN wget -qO - https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list

##Install required pakages
RUN apt -y install wget && apt -y install unzip && apt -y install python-pip && apt -y install git && apt -y install kubectl

##Download terraform binary
RUN wget https://releases.hashicorp.com/terraform/0.11.13/terraform_0.11.13_linux_amd64.zip && unzip terraform_0.11.13_linux_amd64.zip -d /bin/

##Install ansible
RUN pip install ansible==2.6.14

COPY terraform-inventory /bin/terraform-inventory

WORKDIR "/root"

ENTRYPOINT [ "/bin/bash" ]
