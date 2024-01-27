ARG BUILD_FROM=ghcr.io/hassio-addons/base:15.0.5
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

RUN apk add --update --no-cache \
        nodejs=20.11.0-r0 \
        npm=10.2.5-r0 \
        git=2.43.0-r0

RUN git clone https://github.com/dixi83/mqtt-s7-connector.git /usr/src/mqtt-s7-connector

# Copy root filesystem
COPY rootfs /

# Add Config Volume File
VOLUME ["/config"]
COPY ./rootfs/usr/src/mqtt-s7-connector/config.example.json /config/

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
    maintainer="Franck Nijhof <frenck@addons.community>" \
    org.opencontainers.image.title="${BUILD_NAME}" \
    org.opencontainers.image.description="${BUILD_DESCRIPTION}" \
    org.opencontainers.image.vendor="Home Assistant Community Add-ons" \
    org.opencontainers.image.authors="Franck Nijhof <frenck@addons.community>" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.url="https://addons.community" \
    org.opencontainers.image.source="https://github.com/${BUILD_REPOSITORY}" \
    org.opencontainers.image.documentation="https://github.com/${BUILD_REPOSITORY}/blob/main/README.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}

