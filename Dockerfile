ARG RUBY_VERSION=3.1.2

FROM ruby:$RUBY_VERSION

WORKDIR /srv/jekyll
COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .