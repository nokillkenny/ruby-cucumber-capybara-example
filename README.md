# Ruby Cucumber Capybara Example

![CI](https://github.com/nokillkenny/ruby-cucumber-capybara-example/actions/workflows/test.yml/badge.svg)

BDD test automation framework using Cucumber 9.x with Capybara and Selenium WebDriver.

## Stack
- Ruby 3.x
- Cucumber 9.2
- Capybara 3.40
- Selenium WebDriver 4.x (headless Chrome)
- parallel_tests for concurrent execution

## Setup

```bash
bundle install
```

## Local Configuration

Create `.env.local` with your test credentials:

```
BASE_URL=https://the-internet.herokuapp.com
TEST_USER=tomsmith
TEST_PASS=SuperSecretPassword!
```

> These are the public demo credentials for [the-internet.herokuapp.com](https://the-internet.herokuapp.com/login)

## Run Tests

```bash
# Local
bundle exec cucumber

# Docker
docker compose up --build

# Parallel
bundle exec parallel_cucumber features/
```

## Structure

```
features/
├── *.feature           # Gherkin scenarios
├── step_definitions/   # Step implementations
└── support/
    ├── env.rb          # Capybara/driver config
    └── pages/          # Page Object classes
```

## CI

Tests run in GitHub Actions with credentials injected via repository secrets (`TEST_USER`, `TEST_PASS`). HTML reports are uploaded as artifacts and aggregated to a central dashboard via `repository_dispatch`.
