#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
yarn install
yarn build
yarn build:css
bundle exec rake assets:precompile
bundle exec rake assets:clean
bundle exec rake db:migrate