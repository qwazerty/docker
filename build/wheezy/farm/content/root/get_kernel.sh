#! /bin/sh

LINUX_VER=3.14

apt-get -y install git

# DL latest grsecurity patch
wget https://grsecurity.net/testing_rss.php
wget -c $(grep "http.*patch" testing_rss.php | head -n 1 | sed 's/<link>//' | sed 's/<\/link>//')
rm testing_rss.php

# DL latest linux-LINUX_VER
wget https://www.kernel.org/feeds/kdist.xml
wget -c $(grep "https.*linux-${LINUX_VER}.*tar.xz\"" kdist.xml | head -n 1 | sed 's/.*href="//' | sed 's/"&gt.*//')
rm kdist.xml

ARCHIVE=$(ls -t linux-${LINUX_VER}* | head -n 1)
tar xf $ARCHIVE
cd $(echo $ARCHIVE | sed 's/.tar.xz//')
patch -p1 -i $(ls -t ../grsecurity-* | head -n 1)
