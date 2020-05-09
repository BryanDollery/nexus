FROM openjdk:8-jre-alpine

ENV NEXUS_VERSION=3.23.0-03 \
    SONATYPE_DIR=/opt/sonatype \
    NEXUS_HOME=/opt/sonatype/nexus \
    NEXUS_DATA=/nexus-data \
    NEXUS_CONTEXT='' \
    SONATYPE_WORK=/opt/sonatype/sonatype-work \
    JAVA_MAX_MEM=1200m \
    JAVA_MIN_MEM=1200m \
    EXTRA_JAVA_OPTS=""

RUN apk add --no-cache tar bash openssl curl gzip && \
    mkdir -p $SONATYPE_DIR  $NEXUS_HOME && \
    curl -LSs https://sonatype-download.global.ssl.fastly.net/repository/downloads-prod-group/3/nexus-${NEXUS_VERSION}-unix.tar.gz | \
        tar xz --strip-components 1 -C $NEXUS_HOME && \
    adduser -S -u 200 -D -H -h "${NEXUS_DATA}" -s /bin/false nexus nexus && \
    mkdir -p ${NEXUS_DATA}/etc ${NEXUS_DATA}/log ${NEXUS_DATA}/tmp ${SONATYPE_WORK} && \
    ln -s ${NEXUS_DATA} ${SONATYPE_WORK}/nexus3 && \
    chown -R nexus ${NEXUS_HOME}/etc

COPY entrypoint.sh /

WORKDIR ${NEXUS_HOME}
VOLUME ${NEXUS_DATA}
EXPOSE 8081


ENTRYPOINT ["/entrypoint.sh"]
