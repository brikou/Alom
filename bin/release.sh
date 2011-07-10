#!/bin/bash
baseDir=`php -r "echo dirname(dirname(realpath('$0')));"`
tempDir="`mktemp -d`"

echo "Application folder : $baseDir"
echo "Temporary folder   : $tempDir"


# Copy project

cd $baseDir
version="`cat VERSION`"
cp -R * "$tempDir"

# Pre-clean
rm -Rf app/cache/* app/logs/*
rm -Rf web/css web/js

# Update project
cd $tempDir
./bin/vendors install
php bin/build_bootstrap.php

# Generate CSS/JS
./app/console assetic:dump web/ --env=prod --no-debug


# Remove non-needed files
rm -Rf app/cache/* app/logs/*
find bin/    -type f -name "*" ! -name "rst2html-pygments" -delete
find vendor/ -type d -name ".git" | xargs rm -Rf
rm -Rf app/Resources/graphism
rm -Rf app/config/parameters.ini
rm -Rf app/console
rm -Rf app/phpunit.xml.dist
rm -Rf src/Alom/Website/*/DataFixtures
rm -Rf src/Alom/Website/*/Tests
rm -Rf src/Alom/Website/MainBundle/Resources/css
rm -Rf src/Alom/Website/MainBundle/Resources/js
rm -Rf web/bundles
rm -Rf web/config.php
rm -Rf web/app_dev.php
rm VERSION LICENCE deps*

# Compress
cd $tempDir
tar -czf "$baseDir/build-$version.tgz" *
rm -Rf $tempDir