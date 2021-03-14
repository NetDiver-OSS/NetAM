FROM ruby:3.0.0-alpine as build
WORKDIR /app

ENV \
  RAILS_ENV=production \
  RACK_ENV=production \
  NODE_ENV=production \
  SECRET_KEY_BASE=1234

RUN \
  apk add --no-cache build-base nodejs npm yarn postgresql-dev linux-headers zlib-dev tzdata &&\
  rm -rf /var/cache/apk/* &&\
  mkdir -p /app /app/config /app/log/

COPY . /app

RUN \
  bundle config set without 'development test' &&\
  bundle install --jobs $(nproc) --retry 5 &&\
  bin/rake gettext:po_to_json &&\
  bin/rails assets:precompile


FROM ruby:3.0.0-alpine
WORKDIR /app

ENV \
  RAILS_ENV=production \
  RACK_ENV=production \
  NODE_ENV=production \
  RAILS_SERVE_STATIC_FILES=true \
  RAILS_LOG_TO_STDOUT=true

RUN \
  apk add --no-cache nodejs libpq ca-certificates tzdata xz-libs postgresql-client &&\
  rm -rf /var/cache/apk/* &&\
  mkdir -p /app

COPY --from=build /usr/local/bin/gem /usr/local/bin/gem
COPY --from=build /usr/local/bundle/ /usr/local/bundle/
COPY --from=build /app/ /app/
COPY docker/entrypoint.sh /entrypoint.sh

EXPOSE 3000

ENTRYPOINT ["/entrypoint.sh"]
CMD ["rails", "server", "-b", "0.0.0.0"]
