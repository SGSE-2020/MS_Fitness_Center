FROM ruby:2.5

RUN apt-get update -qq && apt-get install -y build-essential
RUN apt install libpq-dev
RUN gem update && gem install bundler
RUN bundle config --global frozen 1

RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile.lock /app/
RUN bundle install

ADD . /app/
EXPOSE 8080

CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0", "-p", "8080"]