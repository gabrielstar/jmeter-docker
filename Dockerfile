FROM alpine:3.6
LABEL maintainer="gabriel.starczewski@capgemini.com"

ARG JMETER_VERSION="5.0"

ENV JMETER_HOME /opt/apache-jmeter-${JMETER_VERSION}
ENV JMETER_BIN ${JMETER_HOME}/bin
#Use this for latest version
#ENV MIRROR_HOST http://mirrors.ocf.berkeley.edu/apache/jmeter
#Or this for specific one that is not latest release
ENV MIRROR_HOST http://archive.apache.org/dist/jmeter
ENV JMETER_DOWNLOAD_URL ${MIRROR_HOST}/binaries/apache-jmeter-${JMETER_VERSION}.tgz
ENV JMETER_PLUGINS_DOWNLOAD_URL http://repo1.maven.org/maven2/kg/apc
ENV JMETER_PLUGINS_FOLDER=${JMETER_HOME}/lib/ext

RUN apk update \
    && apk upgrade \
    && apk add ca-certificates \
    && update-ca-certificates \
    	&& apk add --update curl unzip bash tzdata mc \
    	&& apk add --update openjdk8-jre \
	&& echo "Installed jmeter requirements and basic apk tools" \
	&& cp /usr/share/zoneinfo/Europe/Warsaw /etc/timezone \
    && rm -rf /var/cache/apk/* \
    && mkdir -p /tmp/dependencies \
    && curl -v -L ${JMETER_DOWNLOAD_URL} > /tmp/dependencies/apache-jmeter-${JMETER_VERSION}.tgz \
    && mkdir -p /opt \
    && tar -xzf /tmp/dependencies/apache-jmeter-${JMETER_VERSION}.tgz -C /opt \
    && rm -rf /tmp/dependencies

RUN curl -v -L ${JMETER_PLUGINS_DOWNLOAD_URL}/jmeter-plugins-dummy/0.2/jmeter-plugins-dummy-0.2.jar -o ${JMETER_PLUGINS_FOLDER}/jmeter-plugins-dummy-0.2.jar

COPY run.sh /
ENV PATH ${PATH}:${JMETER_BIN}
WORKDIR ${JMETER_HOME}		
ENTRYPOINT ["/run.sh"]
