FROM ruby:2.5
ENV COMPOSE_CONVERT_WINDOWS_PATHS 1
RUN gem install rails -v '5.2.1'
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /www
WORKDIR /www
COPY Gemfile /www/Gemfile
COPY Gemfile.lock /www/Gemfile.lock
RUN bundle install
COPY . /www
