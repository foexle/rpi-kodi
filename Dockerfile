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
	cifs-utils \
	smbclient \
	samba-common-bin  \
	nfs-common \
	wget \
	libegl1-mesa \
	kbd \
	rpi-update \
	libgles2-mesa

# Download current RPI firmware (inluding kernel modules)
RUN rpi-update
	

COPY config/rdp.conf /etc/ld.so.conf.d/rbp.conf
COPY config/supervisord.conf /etc/supervisor/supervisord.conf
COPY config/advancedsettings.xml /root/.kodi/userdata/advancedsettings.xml

# Cleaning image
RUN apt-get autoclean
RUN rm -rf /var/lib/apt/lists/

RUN ldconfig

# Expose default HTTP port including Samba 
EXPOSE 9777/udp 8080/tcp 1900/udp 137/tcp 138/tcp 139/tcp 445/tcp 9090/tcp

CMD ["/usr/bin/supervisord"]


