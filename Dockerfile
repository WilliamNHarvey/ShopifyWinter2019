FROM gcr.io/google_appengine/ruby

RUN cd /rbenv/plugins/ruby-build && \
    git pull && \
    rbenv install -s 2.5.1 && \
    rbenv global 2.5.1 && \
    gem install bundler --version 1.16.4
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
ENV RBENV_VERSION 2.5.1

# Copy the application files.
RUN mkdir /www
WORKDIR /www
COPY Gemfile /www/Gemfile
COPY Gemfile.lock /www/Gemfile.lock
RUN bundle install && rbenv rehash
COPY . /www

# Set environment variables.
ENV RACK_ENV=production \
    RAILS_ENV=production \
    RAILS_SERVE_STATIC_FILES=true

# Use foreman to start processes. $FORMATION will be set in the pod
# manifest. Formations are defined in Procfile.
CMD rake db:create && rake db:migrate && rake db:seed && bundle exec foreman start --formation "$FORMATION"
