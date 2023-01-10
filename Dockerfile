FROM debian:11-slim
LABEL org.opencontainers.image.authors="notifications@zuptalo.com"

ENV TZ=Europe/Stockholm
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends -y ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    mkdir /root/bin && \
    touch /root/bin/blockedIPs && \
    touch /root/access.log

WORKDIR /root

ARG TARGETOS
ARG TARGETARCH
ADD /tmp/${TARGETOS}/${TARGETARCH} /root/

EXPOSE 54321
VOLUME [ "/etc/x-ui" ]
CMD [ "./x-ui" ]
