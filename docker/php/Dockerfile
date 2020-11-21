FROM centos:7
# Download and install PHP from remi repo
RUN yum update -y && yum install epel-release -y && yum install https://rpms.remirepo.net/enterprise/remi-release-7.rpm -y
RUN yum --enablerepo=remi-php74 install php php-pdo php-mbstring php-bcmath php-pecl-swoole4 php-xml php-redis unzip  -y
# Download and install nodejs repository
RUN curl -sL https://rpm.nodesource.com/setup_14.x | bash -
RUN yum install nodejs -y
# Download and install latest composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php composer-setup.php --install-dir=/usr/bin --filename=composer
RUN chmod +x /usr/bin/composer
# Change to /app directory
WORKDIR /app
# Copy entrypoint bash to container and make it executable
COPY ./start.sh /start.sh
RUN chmod +x /start.sh
# Expose TCP ports
EXPOSE 80/tcp 443/tcp 8081/tcp

CMD [ "/bin/sh","-c","/start.sh" ]
