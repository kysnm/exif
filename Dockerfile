FROM ruby:2.7.1-alpine

#  WORKDIR
#-----------------------------------------------
WORKDIR /app
COPY . /app

#  Insall Package
#-----------------------------------------------
RUN apk update && \
    apk upgrade && \
    apk add --update --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/v3.4/main --virtual=.build-dependencies \
      build-base \
      curl-dev \
      linux-headers \
      libexif-dev=0.6.21-r0 \
#    apk add --update --no-cache \
      git \
      bash \
      wget \
      gdb
#    apk del .build-dependencies


#  TIMEZONE
#-----------------------------------------------
ENV TIMEZONE Asia/Tokyo
RUN ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime

#  GEM Install
#-----------------------------------------------

RUN gem install bundler
RUN bundle install

ENTRYPOINT [ "bundle", "exec", "rake" ]
