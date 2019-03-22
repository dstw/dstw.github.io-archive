FROM jekyll/jekyll:3.8.5

WORKDIR /srv/jekyll

ENTRYPOINT ["jekyll", "serve"]
