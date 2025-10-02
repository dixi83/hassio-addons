ARG BUILD_FROM=ghcr.io/hassio-addons/base:18.1.4
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# renovate: datasource=repology depName=alpine_3_20/nodejs-current versioning=loose
ENV NODEJS_VERSION="23.11.1-r0"
# renovate: datasource=repology depName=alpine_3_20/npm versioning=loose
ENV NPM_VERSION="11.3.0-r1"
# renovate: datasource=repology depName=alpine_3_20/git versioning=loose
ENV GIT_VERSION="2.49.1-r0"


RUN apk add --update --no-cache \
nodejs-current=${NODEJS_VERSION} \
npm=${NPM_VERSION} \
git=${GIT_VERSION} \
\
&& git clone https://github.com/dixi83/mqtt-s7-connector.git /usr/src/mqtt-s7-connector

# Copy root filesystem
COPY rootfs /

# Building the application
WORKDIR /usr/src/mqtt-s7-connector
RUN npm install --only=production

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Martijn Diks" \
    org.opencontainers.image.title="${BUILD_NAME}" \
    org.opencontainers.image.description="${BUILD_DESCRIPTION}" \
    org.opencontainers.image.vendor="Martijn's Home Assistant add-ons" \
    org.opencontainers.image.authors="Martijn Diks" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.url="https://github.com/dixi83/hassio-addons" \
    org.opencontainers.image.source="https://github.com/${BUILD_REPOSITORY}" \
    org.opencontainers.image.documentation="https://github.com/${BUILD_REPOSITORY}/blob/main/README.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}

