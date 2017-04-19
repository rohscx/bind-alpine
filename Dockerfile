MAINTAINER Rohscx <emailaddress.com>

FROM alpine
RUN apk update
RUN apk add --no-cache mysql-client
