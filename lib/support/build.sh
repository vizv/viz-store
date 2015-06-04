#!/bin/bash
set -e
source /etc/profile.d/rvm.sh
rvm install ruby-2.2.0

cd /app
bundle install --deployment --without development test mysql aws
