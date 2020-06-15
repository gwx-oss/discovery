FROM debian
LABEL maintainer.name="Grant Moore" \
maintainer.email="chinchalinchin@gmail.com" \
description="A kibana instance configured for CloudFoundry deployment process"

RUN apt update -y && apt upgrade -y && \
apt install -y wget jq

WORKDIR /home/

RUN wget https://artifacts.elastic.co/downloads/kibana/kibana-5.6.5-amd64.deb
RUN dpkg -i kibana-5.6.5-amd64.deb

EXPOSE 5601

COPY init-kibana.sh /home/init-kibana.sh
COPY kibana.yml /etc/kibana/kibana.yml

CMD [ "bash", "./init-kibana.sh" ]