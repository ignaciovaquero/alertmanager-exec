FROM golang:1.13.7-alpine3.11 as builder

WORKDIR /go/src/github.com/igvaquero18/alertmanager-exec
COPY . .

RUN go build


FROM alpine:3.11.2

LABEL org.opencontainers.image.authors="Ignacio Vaquero <ivaqueroguisasola@gmail.com>" \
      org.opencontainers.image.title="Simple test webhook" \
      org.opencontainers.image.description="Simple test webhook" \
      org.opencontainers.image.version="0.1.0"

COPY --from=builder /go/src/github.com/igvaquero18/alertmanager-exec/alertmanager-exec /go/bin/alertmanager-exec

RUN apk update && \
    apk add tini=0.18.0-r0

EXPOSE 8080/tcp

ENTRYPOINT ["/sbin/tini", "--"]

CMD ["/go/bin/alertmanager-exec"]
