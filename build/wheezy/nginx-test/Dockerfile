FROM wheezy-nginx

ADD content/ /
RUN apt-get update
RUN apt-get -y upgrade
RUN rm /etc/nginx/sites-available/default

CMD nginx
