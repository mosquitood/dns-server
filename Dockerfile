FROM centos:7.4.1708
LABEL maintainer="Mosquitood<mosquitood@gmail.com>"
RUN yum install epel-release -y
RUN yum install nodejs redis -y 
RUN npm install pm2 -g
ADD ./src /data/src
RUN cd /data/src/ && npm install redis native-dns
VOLUME /data
WORKDIR /data
EXPOSE 6379 53 
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
COPY redis.conf /etc/
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["node"]
