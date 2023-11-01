#!/bin/sh

yagna service run &
sleep 5
yagna payment fund
yagna app-key create requestor
cd app
npm install
YAGNA_APPKEY=$(yagna app-key list --json | jq '.[].key' | tr -d '"') HOST_BACKEND=db npm start