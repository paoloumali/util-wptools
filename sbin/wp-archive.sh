#!/usr/bin/env bash

#wpdir=/tmp/wordpress
ln -nsf $WP_DIR /tmp/wordpress
wpdir=/tmp/wordpress
baksdir=/tmp/backups

timestamp=$(date +%s)
htime=$(date -d @$timestamp +%m-%d-%Y_%H-%M-%S)
timename=$timestamp.$htime

## This allows them to rebuild site without wp-content which is mostly big files
cd /tmp
git init
git config --global user.email "dev@paolo.ph"
git config --global user.name "paoloumali"
git checkout master
git add -A
git commit -m "time: $timename"
git checkout -b $htime

cd $wpdir
## db export
wp db export --allow-root db_$timename.sql

## archive it
zip -r $baksdir/wp-archive_latest.zip \
  $wpdir/{.htaccess,wp-config.php,wp-content} \
  *.sql \
  /tmp/.git

## delete remnant db
rm *.sql


