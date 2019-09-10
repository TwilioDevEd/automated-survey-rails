FROM ruby:2.5.6

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
  && apt-get install -y nodejs

WORKDIR /app

COPY . .

RUN bundle install

EXPOSE 3000

VOLUME ["/app"]

CMD ["bundle", "exec", "rails", "s", "--binding", "0.0.0.0", "--port", "3000"]
