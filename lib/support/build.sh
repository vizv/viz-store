#!/bin/bash
set -e
source /etc/profile.d/rvm.sh

cd /app
bundle install --deployment --without development test mysql aws
bundle exec rake assets:precompile RAILS_ENV=production
