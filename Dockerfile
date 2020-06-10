FROM debian

RUN apt update -y && apt upgrade -y && \
apt install -y wget jq

WORKDIR /home/

RUN wget https://artifacts.elastic.co/downloads/kibana/kibana-5.6.0-amd64.deb
RUN dpkg -i kibana-5.6.0-amd64.deb

USER kibana 

EXPOSE 5601

COPY init-kibana.sh /home/init-kibana.sh
COPY kibana.yml /etc/kibana/kibana.yml

CMD [ "./init-kibana.sh" ]