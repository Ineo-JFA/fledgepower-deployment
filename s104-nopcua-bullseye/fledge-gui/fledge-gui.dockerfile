FROM arm32v7/nginx:latest

LABEL author="Akli Rahmoun"

ARG FLEDGEVERSION=1.9.2
ARG RELEASE=1.9.2 
ARG OPERATINGSYSTEM=buster
ARG ARCHITECTURE=armv7l
ARG FLEDGELINK="http://archives.fledge-iot.org/${RELEASE}/${OPERATINGSYSTEM}/${ARCHITECTURE}"

RUN apt-get update

RUN apt-get install -y wget && \ 
    wget --no-check-certificate ${FLEDGELINK}/fledge-gui-${FLEDGEVERSION}.deb && \
    dpkg --unpack fledge-gui-${FLEDGEVERSION}.deb && \
    rm -r /usr/share/nginx/html && \
    mv /var/www/html /usr/share/nginx && \
    mv /usr/share/nginx/html/fledge.html /usr/share/nginx/html/index.html && \
    chown -R  nginx.nginx /usr/share/nginx/html && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/ && \
    rm -rf /var/www/

# Fledge GUI ports
EXPOSE 8080
