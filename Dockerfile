FROM resin/rpi-raspbian


# Update package list and upgrade packages
RUN apt-get update && apt-get upgrade

# Dependency 
RUN apt-get install -y wget apt-utils

# Add Kodi 16.1 Repository
RUN echo 'deb http://pipplware.pplware.pt/pipplware/dists/jessie/main/binary /' | sudo tee --append /etc/apt/sources.list.d/pipplware_jessie.list
RUN wget -O - http://pipplware.pplware.pt/pipplware/key.asc | sudo apt-key add -

RUN apt-get update && apt-get install -y \
	kodi \
	supervisor \
	wget \
	libegl1-mesa \
	kbd \
	rpi-update \
	libgles2-mesa

# Download current RPI firmware 
RUN rpi-update
	

COPY config/rdp.conf /etc/ld.so.conf.d/rbp.conf
COPY config/supervisord.conf /etc/supervisor/supervisord.conf

# Cleaning image
RUN apt-get autoclean
RUN rm -rf /var/lib/apt/lists/


# Expose default HTTP port 
EXPOSE 9777/udp 80/tcp 1900/udp 

ENTRYPOINT /usr/bin/supervisord -n


