#!/bin/bash

# ----- Build master
if [ -d AlamofireSwiftyJSON ]; then
  git -C AlamofireSwiftyJSON pull origin master
else
  git clone --depth 1 --branch master https://github.com/starboychina/AlamofireSwiftyJSON.git AlamofireSwiftyJSON
fi

cd AlamofireSwiftyJSON

jazzy --config ../.jazzy.json --output ../ --module-version "master"
