FROM ruby:3.2-slim

RUN apt-get update && apt-get install -y \
    chromium chromium-driver \
    build-essential \
    --no-install-recommends && rm -rf /var/lib/apt/lists/*

ENV CHROME_BIN=/usr/bin/chromium

WORKDIR /app

# Non-root user
RUN groupadd -r appuser && useradd -r -g appuser appuser

COPY Gemfile Gemfile.lock ./
RUN bundle install && rm -rf /usr/local/bundle/cache

COPY . .

RUN chown -R appuser:appuser /app
USER appuser

CMD ["bundle", "exec", "cucumber", "--tags", "not @error-handling", "--publish-quiet"]
