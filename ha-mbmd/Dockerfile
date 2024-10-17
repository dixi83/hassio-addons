ARG BUILD_FROM=ghcr.io/hassio-addons/base:16.3.3
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# renovate: datasource=repology depName=alpine_3_20/make versioning=loose
ENV MAKE_VERSION="4.4.1-r2"
# renovate: datasource=repology depName=alpine_3_20/go versioning=loose
ENV GO_VERSION="1.22.8-r0"
# renovate: datasource=repology depName=alpine_3_20/git versioning=loose
ENV GIT_VERSION="2.45.2-r0"

RUN apk add --update --no-cache \
make=${MAKE_VERSION} \
go=${GO_VERSION} \
git=${GIT_VERSION} \
\
&& git clone https://github.com/volkszaehler/mbmd.git /root/mbmd

# Copy root filesystem
COPY rootfs /

# Building the application
WORKDIR /root/mbmd
RUN make install && make build

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

