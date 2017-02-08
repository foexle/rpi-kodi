# Desciption
This Dockerfile will build a RaspberryPi docker image with Kodi 16.1 (Jarvis)

 docker build -t rpi-kodi .

It's needed to forward some ports on start of the container
 
 docker run -p 8080:8080 -p 9777:9777/udp -p 1900:1900/udp --privileged  {IMAGE_ID}

> Which HTTP port you're using depends on the Kodi settings. In the most cases are this ports **80** or **8080**

## Attention!!!
The privileged option is a high security risk so please ensure your running container should not be accessable from the WAN.


# Tested on
* Raspberry 3


# TODO
* Samba and NFS share network scan not working 
* Reselution litte bit weired

# Troubleshoots
To get working NFS you need to your storage address an export path

