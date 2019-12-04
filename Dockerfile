##Download base image ubuntu xenial
FROM ubuntu:xenial

MAINTAINER Lorenzo Comotti

##Update packages 
RUN apt -y update

##Install required pakages
RUN apt -y install wget git jq && apt -y --fix-missing install unzip && apt -y --fix-missing install python-pip && apt -y --fix-missing install git && apt -y --fix-missing install apt-transport-https rsync

##Download terraform binary
RUN wget https://releases.hashicorp.com/terraform/0.11.13/terraform_0.11.13_linux_amd64.zip && unzip terraform_0.11.13_linux_amd64.zip -d /bin/

## add kubernetes repository
RUN wget -qO - https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list && apt -y update 

# Install kubectl
RUN apt -y install kubectl=1.14.1-00

##Install ansible
RUN pip install ansible==2.6.14

## Enable ansible vault plugin
RUN pip install hvac
#RUN mkdir -p /etc/ansible/plugin && cd /etc/ansible/plugin && git clone https://github.com/jhaals/ansible-vault.git

COPY terraform-inventory /bin/terraform-inventory

WORKDIR "/root"

ENTRYPOINT [ "/bin/bash" ]
