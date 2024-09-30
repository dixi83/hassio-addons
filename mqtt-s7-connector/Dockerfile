ARG BUILD_FROM=ghcr.io/hassio-addons/base:15.0.9
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

RUN apk add --update --no-cache \
nodejs-current=21.7.3-r0 \
npm=10.8.0-r0 \
git=2.45.2-r0 \
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

