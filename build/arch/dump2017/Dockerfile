FROM base/arch

ADD content/ /
RUN pacman -Syu --noconfirm
RUN pacman -Rddns --noconfirm gcc-libs
RUN pacman -S --noconfirm $(cat /root/packages.list)
RUN chsh -s /usr/bin/zsh
RUN ssh-keygen -A

CMD /usr/sbin/sshd -D -p8022
