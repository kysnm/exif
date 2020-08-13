FROM ruby:2.7.1-alpine

#  WORKDIR
#-----------------------------------------------
WORKDIR /app
COPY . /app

#  Insall Package
#-----------------------------------------------
RUN apk update && \
    apk upgrade && \
    apk add --update --no-cache \
      build-base \
      linux-headers \
      libexif-dev

#  TIMEZONE
#-----------------------------------------------
ENV TIMEZONE Asia/Tokyo
RUN ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime

#  GEM Install
#-----------------------------------------------

RUN gem install bundler
RUN bundle install

ENTRYPOINT [ "bundle", "exec", "rake" ]
