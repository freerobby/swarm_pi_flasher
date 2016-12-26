FROM base

ENV X_SERVICE_NAME=lin_guider
ENV X_DISPLAY_WIDTH=645
ENV X_DISPLAY_HEIGHT=500

# Install prerequisites for lin_guider
RUN apt-get -y install \
  build-essential \
  bzip2 \
  fxload \
  libftdi-dev \
  libqt4-dev \
  libusb-1.0-0-dev \
  tar

# Download, build and install lin_guider
RUN apt-get -y install wget
RUN wget http://downloads.sourceforge.net/project/linguider/4.1.0/lin_guider-4.1.0.tar.bz2
RUN bunzip2 lin_guider-4.1.0.tar.bz2
RUN tar xf lin_guider-4.1.0.tar
RUN cd ./lin_guider_pack/lin_guider && ./configure
RUN cd ./lin_guider_pack/lin_guider && make -j $(grep -c ^processor /proc/cpuinfo)

# Install graphical environment
RUN apt-get -y install \
  websockify \
  x11vnc \
  xvfb

# Needed at runtime for websockify
RUN apt-get -y install \
  python-pip

# Create a script to run our full graphical environment.
RUN echo "#!/usr/bin/env sh" > /start.sh
RUN echo "/usr/bin/Xvfb :0 -screen 0 ${X_DISPLAY_WIDTH}x${X_DISPLAY_HEIGHT}x16 &" >> /start.sh
RUN echo "/usr/bin/x11vnc -display :0 -N -forever &" >> /start.sh
RUN echo "/usr/bin/websockify 6100 localhost:5900 &" >> /start.sh
RUN echo "DISPLAY=:0 /lin_guider_pack/lin_guider/lin_guider" >> /start.sh
RUN echo "" >> /start.sh
RUN chmod +x /start.sh

EXPOSE 5900
EXPOSE 6100

CMD ["/start.sh"]
