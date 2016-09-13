FROM ruby

WORKDIR /app

COPY ./bundle /usr/local/bundle/
COPY ./Gemfile /app
COPY ./Gemfile.lock /app

RUN bundle install && bundle clean
RUN printf '#!/bin/sh\ncp -r /usr/local/bundle /app\n' > /usr/local/bin/cache-bundle
RUN chmod +x /usr/local/bin/cache-bundle

COPY ./ /app

CMD bundle exec ruby -e "puts 'hello'"
