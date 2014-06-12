FROM wheezy-base

ADD content/ /

RUN rm /dev/null && mknod /dev/null c 1 3 && chmod 666 /dev/null
RUN mknod /dev/random c 1 8
RUN mknod /dev/urandom c 1 9
RUN mknod /dev/tty c 5 0

RUN apt-get -y install openssh-server

RUN mkdir /var/run/sshd

CMD /usr/sbin/sshd -D
