#base images
FROM centos

COPY ./files/jdk-8u131-linux-x64.tar.gz /mnt/

RUN \cp -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && yum install -y wget vim net-tools \
    && cd mnt \
    && tar zxf jdk-8u131-linux-x64.tar.gz \
    && mv /mnt/jdk1.8.0_131 /usr/local/java1.8 \
    && groupadd logstash \
    && useradd -g logstash logstash \
    && wget https://artifacts.elastic.co/downloads/logstash/logstash-6.5.4.tar.gz \
    && tar zxf logstash-6.5.4.tar.gz \
    && mv logstash-6.5.4 /usr/local/logstash \
    && cp -r  /usr/local/logstash/config /home/logstash/ \
    && rm -rf /mnt/* \
    && yum clean all


ADD ./files/setup.sh /tmp/setup.sh 
RUN chmod 755 /tmp/setup.sh

ENV JAVA_HOME /usr/local/java1.8	
ENV JRE_HOME ${JAVA_HOME}/jre
ENV CLASSPATH .:${JAVA_HOME}/lib:${JRE_HOME}/lib:$CLASSPATH
ENV JAVA_PATH ${JAVA_HOME}/bin:${JRE_HOME}/bin
ENV PATH $PATH:${JAVA_PATH}
ENTRYPOINT ["/tmp/setup.sh"]
