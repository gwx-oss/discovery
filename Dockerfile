FROM ubuntu
LABEL maintainer.name="Grant Moore" \
        maintainer.email="chinchalinchin@gmail.com" \
        description="A logstash instance configured for CloudFoundry deployment process"

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y wget jq openjdk-8-jdk

WORKDIR /home/

RUN wget https://artifacts.elastic.co/downloads/logstash/logstash-6.0.0.tar.gz
RUN tar xzf logstash-6.0.0.tar.gz

COPY calc_test_data.csv /home/calc_test_data.csv
COPY log.conf /home/log.conf
COPY logstash.yml /home/logstash-6.0.0/config/logstash.yml
COPY init-logstash.sh /home/init-logstash.sh

EXPOSE 9600 

RUN apt-get install -y lsof nmap

CMD [ "bash", "./init-logstash.sh"]