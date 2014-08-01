FROM ubuntu:14.04

ADD content/ /
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install zsh vim htop tree git
RUN chsh -s /usr/bin/zsh
