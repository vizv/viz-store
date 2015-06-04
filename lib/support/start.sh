#!/bin/bash
set -e
source /etc/profile.d/rvm.sh

cd /app
rvmsudo -u git -H bundle exec rails server RAILS_ENV=production
