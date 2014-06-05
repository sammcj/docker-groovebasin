# GrooveBasin image
# ORIGINAL MAINTAINER Simon Morvan garphy@zone84.net
# Modified to use stackbrew and remove supervisord
# use stackbrew's super-small ubuntu
FROM stackbrew/ubuntu:13.10
ENV DEBIAN_FRONTEND noninteractive

ADD build.sh /tmp/build.sh
RUN /tmp/build.sh

USER groovebasin
ENV HOME /home/groovebasin
WORKDIR /home/groovebasin
RUN ln -s /music /home/groovebasin/music && \
    ln -s /groove /home/groovebasin/groovebasin.db

EXPOSE 16242
EXPOSE 6600

VOLUME /music
VOLUME /groove

ENTRYPOINT ["node","/home/groovebasin/groovebasin-build/lib/server.js"]
