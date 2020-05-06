FROM centos:7

RUN yum update -y && yum install epel-release -y && yum install https://rpms.remirepo.net/enterprise/remi-release-7.rpm -y
RUN yum --enablerepo=remi-php74 install php php-pdo php-mbstring php-bcmath php-pecl-swoole4 php-xml unzip  -y

RUN curl https://getcomposer.org/download/1.10.5/composer.phar > /usr/bin/composer
RUN chmod +x /usr/bin/composer

WORKDIR /app
COPY ./start.sh /start.sh
RUN chmod +x /start.sh
EXPOSE 80/tcp 443/tcp 8081/tcp

CMD [ "/bin/sh","-c","/start.sh" ]
# CMD [ "tail","-f","/dev/null" ]
