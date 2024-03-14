ARG  ALPINE_IMAGE="alpine:3.19.1"
FROM ${ALPINE_IMAGE}

RUN apk --no-cache add clamav clamav-libunrar bash coreutils \
    && mkdir /run/clamav \
    && chown clamav:clamav /run/clamav

RUN sed -i 's/^#Foreground .*$/Foreground true/g'                                /etc/clamav/clamd.conf \
    && sed -i 's/^#TCPSocket .*$/TCPSocket 3310/g'                               /etc/clamav/clamd.conf \
    && sed -i 's/^User .*$/User root/g'                                          /etc/clamav/clamd.conf \
    && sed -i 's/^#LocalSocketGroup .*$/LocalSocketGroup root/g'                 /etc/clamav/clamd.conf \
    && sed -i 's/^#MaxDirectoryRecursion .*$/MaxDirectoryRecursion 50/g'         /etc/clamav/clamd.conf \
    && sed -i 's/^#Foreground .*$/Foreground true/g'                             /etc/clamav/freshclam.conf

COPY entrypoint.sh /usr/bin/

EXPOSE 3310

RUN freshclam --quiet

ENTRYPOINT [ "entrypoint.sh" ]
