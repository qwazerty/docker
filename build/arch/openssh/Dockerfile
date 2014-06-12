FROM base/arch

ADD content/ /
RUN pacman -Syu --noconfirm
RUN pacman -S --noconfirm htop less openssh rxvt-unicode-terminfo tree vim zsh
RUN chsh -s /usr/bin/zsh
RUN ssh-keygen -A

CMD /usr/sbin/sshd -D
