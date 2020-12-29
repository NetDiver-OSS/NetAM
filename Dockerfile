FROM ruby:2.7.2-alpine as build
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

#COPY . /app
COPY app /app/app
COPY bin /app/bin
COPY config /app/config
COPY db /app/db
COPY docker /app/docker
COPY lib /app/lib
COPY locale /app/locale
COPY public /app/public
COPY .browserslistrc /app/.browserslistrc
COPY babel.config.js /app/babel.config.js
COPY config.ru /app/config.ru
COPY crowdin.yml /app/crowdin.yml
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
COPY LICENSE /app/LICENSE
COPY package.json /app/package.json
COPY postcss.config.js /app/postcss.config.js
COPY Rakefile /app/Rakefile
COPY VERSION /app/VERSION
COPY yarn.lock /app/yarn.lock

RUN \
  bundle config set without 'development test' &&\
  bundle install --jobs $(nproc) --retry 5 &&\
  bin/rake gettext:po_to_json &&\
  bin/rails assets:precompile


FROM ruby:2.7.2-alpine
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
