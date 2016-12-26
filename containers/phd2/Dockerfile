FROM base

ENV X_SERVICE_NAME=phd2
ENV X_DISPLAY_WIDTH=860
ENV X_DISPLAY_HEIGHT=660

# Install prerequisites for lin_guider
RUN apt-get -y install \
  build-essential \
  cmake \
  libindi-dev \
  libnova-dev \
  libwxgtk3.0-dev \
  pkg-config \
  wx-common \
  wx3.0-i18n \
  zlib1g-dev

# Download, build and install PHD2
RUN apt-get -y install git
RUN git clone --depth 1 https://github.com/OpenPHDGuiding/phd2.git /phd2
RUN mkdir /phd2/tmp
RUN cd /phd2/tmp && cmake ..
RUN cd /phd2/tmp && make -j $(grep -c ^processor /proc/cpuinfo)
RUN cd /phd2/tmp && make install

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
RUN echo "DISPLAY=:0 /usr/local/bin/phd2" >> /start.sh
RUN echo "" >> /start.sh
RUN chmod +x /start.sh

EXPOSE 5900
EXPOSE 6100

CMD ["/start.sh"]
