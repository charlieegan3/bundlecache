FROM ruby

WORKDIR /app

ADD ./bundle.tar.gz /
COPY ./Gemfile /app
COPY ./Gemfile.lock /app

RUN bundle install && bundle clean
RUN printf '#!/bin/sh\ntar -zcf /app/bundle.tar.gz /usr/local/bundle\n' > /usr/local/bin/cache-bundle
RUN chmod +x /usr/local/bin/cache-bundle

COPY ./ /app

CMD bundle exec ruby -e "puts 'hello'"
