# Desciption
This Dockerfile will build a RaspberryPi docker image with Kodi 16.1 (Jarvis)

 docker build -n rpi-kodi .

It's needed to forward some ports on start of the container
 
 docker run -p 8080:8080 -p 9777:9777/udp -p 1900:1900/udp --privileged  {IMAGE_ID}

## Attention!!!
The privileged option is a high security risk so please ensure your running container should not be accessable from the WAN.

# Tested on
* Raspberry 3




