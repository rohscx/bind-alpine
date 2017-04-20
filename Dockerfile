FROM alpine

MAINTAINER Rohscx <emailaddress.com>

RUN apk update

RUN apk add bind

RUN apk add bash-completion

COPY docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT [ "/docker-entrypoint.sh" ]

RUN chmod 755 /docker-entrypoint.sh

CMD [ "-s" ]

EXPOSE  53
