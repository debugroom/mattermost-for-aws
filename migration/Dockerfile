# Dockerfile for mattermost server

#FROM            docker.io/centos:centos7
#MAINTAINER      debugroom
#
#ENV MATTERMOST_VERSION=5.21.0 \
#    MATTERMOST_SITE_URL="https://mattermost.example.com" \
#    MATTERMOST_HOME=/usr/local/mattermost \
#    MATTERMOST_DB_USER=mattermost \
#    MATTERMOST_DB_PASSWORD=mattermost
#
#RUN yum install -y zip unzip wget
#RUN wget https://releases.mattermost.com/${MATTERMOST_VERSION}/mattermost-${MATTERMOST_VERSION}-linux-amd64.tar.gz
#RUN tar -xvzf *.gz
#RUN mv mattermost ${MATTERMOST_HOME}
#RUN mkdir ${MATTERMOST_HOME}/data
#RUN rm *.gz
#RUN useradd --system --user-group mattermost
#RUN chown -R mattermost:mattermost ${MATTERMOST_HOME}
#RUN chmod -R g+w ${MATTERMOST_HOME}
#RUN sed -e 's/"DriverName": "mysql"/"DriverName": "postgres"/g' ${MATTERMOST_HOME}/config/config.json > ${MATTERMOST_HOME}/config/config.json.tmp1
#RUN sed -e 's/"DataSource": "mmuser:mostest@tcp(localhost:3306)\/mattermost_test?charset=utf8mb4,utf8\\u0026readTimeout=30s\\u0026writeTimeout=30s"/"DataSource": "postgres:\/\/'${MATTERMOST_DB_USER}':'${MATTERMOST_DB_PASSWORD}'@'${RDS_ENDPOINT}':5432\/mattermost?sslmode=disable\\u0026connect_timeout=10"/g' ${MATTERMOST_HOME}/config/config.json.tmp1 > ${MATTERMOST_HOME}/config/config.json.tmp2
#RUN sed -e 's/"SiteURL": "'${MATTERMOST_SITE_URL}'"/g' ${MATTERMOST_HOME}/config/config.json.tmp2 > ${MATTERMOST_HOME}/config/config.json
#
#WORKDIR ${MATTERMOST_HOME}
#EXPOSE 8065
#
#USER mattermost
#CMD ["./bin/mattermost"]

FROM alpine:3.10

# Some ENV variables
ENV PATH="/mattermost/bin:${PATH}"
ENV MM_VERSION=6.0.2

# Build argument to set Mattermost edition
ARG edition=enterprise
ARG PUID=2000
ARG PGID=2000
ARG MM_BINARY=""

# Install some needed packages
RUN apk add --no-cache \
	ca-certificates \
	curl \
	jq \
	libc6-compat \
	libffi-dev \
    libcap \
	linux-headers \
	mailcap \
	netcat-openbsd \
	xmlsec-dev \
	tzdata \
	&& rm -rf /tmp/*

# Get Mattermost
RUN mkdir -p /mattermost/data /mattermost/plugins /mattermost/client/plugins \
    && if [ ! -z "$MM_BINARY" ]; then curl $MM_BINARY | tar -xvz ; \
      elif [ "$edition" = "team" ] ; then curl https://releases.mattermost.com/$MM_VERSION/mattermost-team-$MM_VERSION-linux-amd64.tar.gz | tar -xvz ; \
      else curl https://releases.mattermost.com/$MM_VERSION/mattermost-$MM_VERSION-linux-amd64.tar.gz | tar -xvz ; fi \
    && cp /mattermost/config/config.json /config.json.save \
    && rm -rf /mattermost/config/config.json \
    && addgroup -g ${PGID} mattermost \
    && adduser -D -u ${PUID} -G mattermost -h /mattermost -D mattermost \
    && chown -R mattermost:mattermost /mattermost /config.json.save /mattermost/plugins /mattermost/client/plugins \
    && setcap cap_net_bind_service=+ep /mattermost/bin/mattermost

USER mattermost

#Healthcheck to make sure container is ready
HEALTHCHECK CMD curl --fail http://localhost:8000 || exit 1

# Configure entrypoint and command
COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
WORKDIR /mattermost
CMD ["mattermost"]

# Expose port 8000 of the container
EXPOSE 8000

# Declare volumes for mount point directories
VOLUME ["/mattermost/data", "/mattermost/logs", "/mattermost/config", "/mattermost/plugins", "/mattermost/client/plugins"]