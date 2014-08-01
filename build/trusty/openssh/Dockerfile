FROM trusty-base

ADD content/ /

RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get -y install openssh-server openssh-client
RUN sed -i 's/UsePAM yes/UsePAM no/' /etc/ssh/sshd_config

RUN mkdir -p /var/run/sshd

CMD /usr/sbin/sshd -D
