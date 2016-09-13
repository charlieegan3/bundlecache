FROM ruby

WORKDIR /app

COPY ./bundle /usr/local/bundle/
COPY ./Gemfile /app
COPY ./Gemfile.lock /app

RUN bundle install && bundle clean

COPY ./ /app
RUN chmod +x cache_bundle.sh

CMD bundle exec ruby -e "puts 'hello'"
