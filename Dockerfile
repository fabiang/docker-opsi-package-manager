ARG OPSI_BASE_VERSION=latest
FROM alpine AS download

ARG OPSI_VERSION=4.1.1.33-4

WORKDIR /build

RUN apk --update --no-cache add wget unzip gettext \
    && wget https://github.com/opsi-org/opsi-utils/archive/$OPSI_VERSION.zip -O opsi-utils.zip \
    && unzip opsi-utils.zip -d /build \
    && cp /build/opsi-utils-$OPSI_VERSION/opsi-package-manager /usr/local/bin/opsi-package-manager

FROM fabiang/opsi-base:$OPSI_BASE_VERSION

COPY --from=download /usr/local/bin/opsi-package-manager /usr/local/bin/opsi-package-manager
ENTRYPOINT ["/usr/local/bin/opsi-package-manager"]
