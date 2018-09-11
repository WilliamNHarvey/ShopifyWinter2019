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
USER root
EXPOSE 3000 28080
# Default command:
CMD bundle exec puma --bind tcp://0.0.0.0:3000
