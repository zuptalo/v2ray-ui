FROM golang:latest AS builder
WORKDIR /root
COPY . .
RUN go build main.go

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
COPY --from=builder /root/main /root/x-ui
EXPOSE 54321
VOLUME [ "/etc/xray" ]
CMD [ "./x-ui" ]
