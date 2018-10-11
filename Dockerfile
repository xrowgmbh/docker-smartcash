FROM ubuntu:bionic

ARG smartcashVersion=1.2.6r1-0bionic1
ARG _smartcashBin=/opt/smartcash/smartcashd
ARG _entryPointBin=/opt/docker-entrypoint.sh

ENV WALLET_CONF /etc/smartcash/smartcash.conf
ENV WALLET_DATA /data/

RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:smartcash/ppa && \
    apt-get update && \
    apt-get install -y smartcashd=$smartcashVersion

COPY /docker-entrypoint.sh $_entryPointBin

RUN mkdir -p `dirname $WALLET_CONF` && \
    mkdir -p `dirname $_smartcashBin` && \
    chmod +x $_entryPointBin && \
    ln -s $_entryPointBin /usr/local/bin/docker-entry

VOLUME /data


EXPOSE 9678 22350

ENTRYPOINT ["docker-entry"]

