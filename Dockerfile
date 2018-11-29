FROM golang:1.11-alpine AS builder
#/go/src/github.com/afirth/heel-hooks/
RUN apk --no-cache add -t curl && \
  curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh
  
RUN mkdir /static && \
curl http://unnecessaryheelhooks.com/chris_heelhook.jpg -o /static/chris_heelhook.jpg
ADD . /src
ARG REPO_NAME=undefined
RUN mv /src /go/src/$REPO_NAME && \
  cd /go/src/$REPO_NAME && \
  dep ensure && \
  go build -ldflags "-X main.Version=$(cat VERSION)" -o /bin/app

FROM alpine:latest
COPY --from=builder /bin/app .
COPY --from=builder /static /static
ENTRYPOINT ["./app"]
