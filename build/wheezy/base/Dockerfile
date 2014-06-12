FROM tianon/debian:wheezy

ADD content/ /
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install zsh vim
RUN chsh -s /usr/bin/zsh
