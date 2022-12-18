FROM alpine
ARG VERSION

RUN wget https://github.com/koka-lang/koka/releases/download/v$VERSION/koka-v$VERSION-alpine-x64.apk \
    && apk add --allow-untrusted koka-v$VERSION-alpine-x64.apk \
    && rm koka-v$VERSION-alpine-x64.apk
ENTRYPOINT ["/usr/bin/koka"]
CMD ["--help"]