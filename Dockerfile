# docker build -t gonstr/keycloak-gatekeeper:latest .
# docker push gonstr/keycloak-gatekeeper:latest

FROM golang:alpine as builder

RUN apk update && apk add git
COPY . /build
WORKDIR /build
RUN CGO_ENABLED=0 GOOS=linux go build -o /opt/app

FROM alpine
COPY --from=builder /opt/app /opt/app
RUN addgroup -S app && adduser -S -G app app
USER app
ENTRYPOINT ["/opt/app"]
