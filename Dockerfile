FROM resin/rpi-raspbian


# Update package list and upgrade packages
RUN apt-get update && apt-get upgrade

# Dependency 
RUN apt-get install wget

# Add Kodi 16.1 Repository
RUN echo 'deb http://pipplware.pplware.pt/pipplware/dists/jessie/main/binary /' | sudo tee --append /etc/apt/sources.list.d/pipplware_jessie.list
RUN wget -O - http://pipplware.pplware.pt/pipplware/key.asc | sudo apt-key add -

RUN apt-get install \
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
COPY config/supervisor.conf

# Load linked firmware 

# Expose default HTTP port 
EXPOSE 9777/udp 8080/tcp

CMD ["/usr/bin/supervisord"]

