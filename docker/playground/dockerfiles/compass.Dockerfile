
FROM eclipse-temurin:8-focal

RUN set -x && \
    ln -snf /usr/bin/bash /usr/bin/sh && \
    apt-get update -q && \
    apt-get install -yq retry busybox && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir /opt/busybox && \
    busybox --install /opt/busybox

ENV PATH=/opt/java/openjdk/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/busybox

COPY compass-v1.1.2.tar.gz /opt

# compass
RUN tar -xzf /opt/compass-*.tar.gz -C /opt && \
    rm /opt/compass-*.tar.gz && \
    ln -s /opt/compass-* /opt/compass

COPY conf/compass_env.sh /opt/compass/conf


ENTRYPOINT ["/opt/compass/bin/start_all.sh", "run"]
