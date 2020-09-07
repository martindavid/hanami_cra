FROM ruby:2.6-alpine3.11
MAINTAINER Martin Valentino <mvalentino@martinlabs.me>

RUN apk add --no-cache build-base postgresql postgresql-dev libpq
RUN gem install bundler:2.1.4

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install -j $(nproc) --quiet


COPY . /app

EXPOSE 2300
ENTRYPOINT ["bundle", "exec"]
