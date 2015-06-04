#!/bin/bash
set -e
source /etc/profile.d/rvm.sh

cd /app

export STORE_ADDRESS="${STORE_PORT_27017_TCP_ADDR}:${STORE_PORT_27017_TCP_PORT}"

if [ "$FORCE_RESET_DB" = "true" ]
then
    bundle exec rake db:purge
    bundle exec rake db:seed
fi

if [ "$RAILS_ENV" = "production" ]
then
    bundle exec rake assets:precompile
    bundle exec unicorn
else
    bundle exec rails s -p 8080
fi
