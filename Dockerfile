FROM ruby:3.2.2-slim-buster

# Common dependencies
RUN apt-get update -qq \
  && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
  build-essential \
  gnupg2 \
  curl \
  less \
  git \
  pkg-config

# Clean up
RUN apt-get clean \
  && rm -rf /var/cache/apt/archives/* \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && truncate -s 0 /var/log/*log


ENV APP_ENV=development \
  RACK_ENV=development \
  LANG=C.UTF-8

ENV PROJECT_HOME=/myapp
WORKDIR $PROJECT_HOME

RUN gem install bundler
COPY Gemfile $PROJECT_HOME/Gemfile
COPY Gemfile.lock $PROJECT_HOME/Gemfile.lock

RUN bundle config set force_ruby_platform true && bundle install

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

CMD ["rails", "server", "-b", "0.0.0.0"]