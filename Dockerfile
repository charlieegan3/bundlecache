FROM ruby

WORKDIR /app

COPY ./bundle /usr/local/bundle/
COPY ./Gemfile /app
COPY ./Gemfile.lock /app

RUN bundle install

COPY ./ /app

CMD bundle exec ruby -e "puts 'hello'"
