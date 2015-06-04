FROM vizv/rvm-ruby_2_2_0-rails_4_2_1:latest
MAINTAINER Viz <viz@linux.com>

ADD . /app/
WORKDIR /app/
RUN /app/lib/support/build.sh

EXPOSE 3000
ENTRYPOINT /app/lib/support/start.sh
