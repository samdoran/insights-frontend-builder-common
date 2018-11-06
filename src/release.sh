#!/usr/bin/env bash
set -e
set -x

APP_NAME=`node -e 'console.log(require("./package.json").insights.appname)'`

git clone ${REPO}.git -b $1
cd dist

if [[ "${TRAVIS_BRANCH}" = "prod-stable" || "${TRAVIS_BRANCH}" = "prod-beta" ]]
then
    cp ../.travis/58231b16fdee45a03a4ee3cf94a9f2c3 ./58231b16fdee45a03a4ee3cf94a9f2c3
    sed -s "s/__APP_NAME__/$APP_NAME/" -i ./58231b16fdee45a03a4ee3cf94a9f2c3
fi

git init
git config --global user.name $COMMIT_AUTHOR_USERNAME
git config --global user.email $COMMIT_AUTHOR_EMAIL
git remote add travis-build ${REPO}.git
git add .
git commit -m "${TRAVIS_COMMIT_MESSAGE}"
git push --force --set-upstream travis-build HEAD:$1