FROM ruby:2.5.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /www
WORKDIR /www
COPY Gemfile /www/Gemfile
COPY Gemfile.lock /www/Gemfile.lock
RUN bundle install
COPY . /www
