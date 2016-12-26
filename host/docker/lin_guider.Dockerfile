FROM debian:jessie
# Install lin_guider
RUN apt-get -y install libusb-1.0-0-dev libqt4-dev libftdi-dev fxload
RUN apt-get -y install wget
RUN cd /root && wget http://downloads.sourceforge.net/project/linguider/4.1.0/lin_guider-4.1.0.tar.bz2
RUN apt-get -y install bzip2 tar
RUN cd /root && bunzip2 lin_guider-4.1.0.tar.bz2 && tar xf lin_guider-4.1.0.tar
RUN apt-get -y install build-essential
RUN cd /root/lin_guider_pack/lin_guider && ./configure && make
CMD echo 'No command specified.'

