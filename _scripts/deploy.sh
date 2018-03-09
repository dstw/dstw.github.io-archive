#!/bin/bash
#
# Source:
# - https://github.com/felixrieseberg/travis-jekyll-git
# - https://savaslabs.com/2016/10/25/deploy-jekyll-with-travis.html

if [[ $TRAVIS_BRANCH == 'source' ]] ; then
  git clone https://${GH_TOKEN}@github.com/dstw/dstw.github.io.git ../dstw.github.io.master
  cd ../dstw.github.io.master
  git checkout master
  rm -rf *
  rm .travis.yml

  # Copy generated HTML site from source branch in original repository.
  # Now the `master` branch will contain only the contents of the _site directory.
  cp -R ../dstw.github.io/_site/* .
  cp ../dstw.github.io/.travis.yml .

  git config user.name "Travis CI bot"
  git config user.email ${GH_EMAIL}

  git status
  git add -A .
  git commit -a -m "Travis #$TRAVIS_BUILD_NUMBER"

  # We redirect any output to
  # /dev/null to hide any sensitive credential data that might otherwise be exposed.
  git push --quiet --force origin master > /dev/null 2>&1
else
  echo 'Invalid branch. You can only deploy from source.'
  exit 1
fi
