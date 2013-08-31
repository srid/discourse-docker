#!/bin/bash

set -xe

cd /discourse

# production database
sed -i "s/database: discourse_prod/database: postgres/" config/database.yml
sed -i "s/# username: discourse_prod/username: root/" config/database.yml
sed -i "s/# password: itisagooddaytovi/password: postgres/" config/database.yml
sed -i "s/# host: dbhost/host: $POSTGRES_HOST\n  port: $POSTGRES_PORT/" config/database.yml

# test db
sed -i "s/# username: discourse_test/username: root/" config/database.yml
sed -i "s/# password: 123123123123/password: postgres/" config/database.yml
sed -i "s/host: localhost/host: $POSTGRES_HOST\n  port: $POSTGRES_PORT/" config/database.yml

# set site domain
sed -i "s/production.localhost/discourse.example.com/" config/database.yml

# http://stackoverflow.com/a/7529711
sed -i "s/timeout: 5000/timeout: 5000\n  template: template0/" config/database.yml

# postmark mailer
if [ ! -z "$POSTMARK_API_KEY" ]; then
    sed -i "s/sendmail/postmark/" config/environments/production.rb
    sed -i "s/{arguments: '-i'}/{ :api_key => \"$POSTMARK_API_KEY\" }/" config/environments/production.rb
fi

echo "production.rb =>"
cat /discourse/config/environments/production.rb

echo "database.yml =>"
cat /discourse/config/database.yml

