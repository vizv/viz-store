#!/bin/bash
set -e
source /etc/profile.d/rvm.sh

cd /app

if [ "$FORCE_RESET_DB" = "true" ]
then
    bundle exec rake db:reset
fi

if [ "$RAILS_ENV" = "production" ]
then
    bundle exec rake assets:precompile
    bundle exec unicorn
else
    bundle exec rails s -p 8080
fi
