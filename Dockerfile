# syntax=docker/dockerfile:1.7

FROM golang:1.22.3-alpine3.19 AS builder

WORKDIR /src

COPY go.mod ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -trimpath -ldflags="-s -w" -o /out/app .

FROM alpine:3.19 AS runtime

RUN addgroup -S -g 10001 app \
    && adduser -S -u 10001 -G app -H -s /sbin/nologin app

WORKDIR /app

COPY --from=builder --chown=10001:10001 /out/app ./app
COPY --chown=10001:10001 templates ./templates
COPY --chown=10001:10001 assets ./assets
COPY --chown=10001:10001 banners ./banners

USER 10001:10001

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wget -q --spider http://127.0.0.1:8080/ || exit 1

ENTRYPOINT ["./app"]
