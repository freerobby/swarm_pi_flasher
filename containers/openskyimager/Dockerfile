FROM base

ENV X_SERVICE_NAME=OpenSkyImager
ENV X_DISPLAY_WIDTH=870
ENV X_DISPLAY_HEIGHT=550

# Install prerequisites for lin_guider
RUN apt-get -y install \
  cmake \
  fxload \
  libcfitsio3-dev \
  libglib2.0-0 \
  libglib2.0-dev \
  libgtk2.0-0 \
  libgtk2.0-dev \
  libgtk-3-0 \
  libgtk-3-dev \
  libudev-dev

# Install ATIK Camera support on supported platforms
RUN apt-get -y install \
  sudo \
  wget

RUN echo "#!/usr/bin/env bash" > /install-atik.sh
RUN echo "ARCH=$(/usr/bin/lscpu | /bin/grep "Architecture\:" | /bin/sed "s/Architecture\:\s\+//")" >> /install-atik.sh
RUN echo "if [[ \$ARCH == "x86_64" ]]; then wget http://download.cloudmakers.eu/atikccd-1.11-amd64.deb && dpkg -i atikccd-1.11-amd64.deb; fi" >> /install-atik.sh
RUN echo "if [[ \$ARCH == "armv7l" ]]; then wget http://download.cloudmakers.eu/atikccd-1.11-armhf.deb && dpkg -i atikccd-1.11-armhf.deb; fi" >> /install-atik.sh
RUN echo "apt-get -fy install" >> /install-atik.sh
RUN chmod +x /install-atik.sh
RUN /install-atik.sh


# Download, build and install lin_guider
RUN apt-get -y install git
RUN git clone --depth 1 https://github.com/freerobby/OpenSkyImager.git /OpenSkyImager
RUN mkdir /OpenSkyImager/build
RUN cd /OpenSkyImager/build && cmake -D FORCE_QHY_ONLY=false ..
RUN cd /OpenSkyImager/build && make -j 1 # OSI's dependency chain cannot guarantee successful parallel builds, so only use one core.
RUN cd /OpenSkyImager/build && make install

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
RUN echo "DISPLAY=:0 /usr/local/bin/OpenSkyImager/gtkImager" >> /start.sh
RUN echo "" >> /start.sh
RUN chmod +x /start.sh

EXPOSE 5900
EXPOSE 6100

CMD ["/start.sh"]
