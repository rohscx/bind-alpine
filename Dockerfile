FROM alpine

MAINTAINER Rohscx <emailaddress.com>

RUN apk update

RUN apk bind

RUN apk add bash-completion

EXPOSE  53
