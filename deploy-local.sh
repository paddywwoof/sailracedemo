#!/usr/bin/env bash

# Build the server project
pushd sailracetimerserver
./gradlew build fatJar
popd

# Build the results widget
pushd sailraceresults
REACT_APP_API_SERVER="localhost:8080"
npm install
npm run build
popd

# Copy build products to the static web server folder
cp -r sailraceresults/build front/static/results

docker-compose down
docker-compose build
docker-compose up -d
docker-compose logs -f
