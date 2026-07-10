FROM ruby:3.2.2-slim

RUN apt-get update -qq && apt-get install -y --no-install-recommends \
      build-essential \
      libsqlite3-dev \
      git \
      pkg-config \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY Gemfile Gemfile.lock* ./
RUN bundle install

COPY . .

RUN mkdir -p storage log tmp/pids \
    && chmod +x bin/rails bin/setup entrypoint.sh

ENV RAILS_ENV=development
EXPOSE 3000

ENTRYPOINT ["./entrypoint.sh"]
CMD ["bin/rails", "server", "-b", "0.0.0.0"]
