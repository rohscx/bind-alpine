FROM alpine

MAINTAINER Rohscx <emailaddress.com>

RUN apk update

RUN apk add bind

RUN apk add bash-completion

ENTRYPOINT [ "/docker-entrypoint.sh" ]

CMD [ "-s" ]

EXPOSE  53
