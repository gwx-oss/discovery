FROM debian

RUN apt update -y && apt upgrade -y && \
apt install -y wget openjdk-11-jdk file

WORKDIR /opt/

RUN wget http://apache.mirrors.hoobly.com/zookeeper/zookeeper-3.6.1/apache-zookeeper-3.6.1-bin.tar.gz
RUN tar xvf apache-zookeeper-3.6.1-bin.tar.gz
RUN mkdir zookeeper
RUN mv apache-zookeeper-3.6.1-bin zookeeper
RUN mkdir -p /data/zookeeper/
COPY zoo.cfg /opt/zookeeper/apache-zookeeper-3.6.1-bin/conf/zoo.cfg

WORKDIR /opt/zookeeper/apache-zookeeper-3.6.1-bin/bin/
RUN ls
EXPOSE 2181 8080

CMD [ "bash" ,"zkServer.sh", "start-foreground" ]      