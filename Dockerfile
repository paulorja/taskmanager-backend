FROM ruby:2.6.4

# https://github.com/nodesource/distributions#installation-instructions
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
        && apt-get install -y nodejs


RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN mkdir /webapp

WORKDIR /webapp

ADD Gemfile /webapp/Gemfile
ADD Gemfile.lock /webapp/Gemfile.lock

RUN gem install bundler

RUN bundle install

ADD . /webapp
