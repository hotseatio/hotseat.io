# hotseat.io

The monorepo for [hotseat.io](https://hotseat.io).

## Install Dependencies

### macOS

Install [Homebrew](https://brew.sh/). Then run:

```sh
brew tap elastic/tap
brew install docker --cask
brew install go rbenv nodenv yarn pre-commit terraform postgresql@15 stripe/stripe-cli/stripe serverless graphviz elastic/tap/elasticsearch-full redis memcached

# You may have to start the DB, Redis, and ElasticSearch services:
brew services start memcached
brew services start postgresql@15
brew services start redis
brew services start elasticsearch-full
```

### Arch / Manjaro (Linux)

(Using pamac, but any AUR helper should work.)

```sh
pacman -S docker go nodejs yarn python-pre-commit terraform postgresql opensearch
pamac build ruby-build stripe-cli-bin

# You may have to start the DB and OpenSearch services:
systemctl start opensearch.service postgresql.service
```

## Setup

```sh
# Get the code to Hotseat!
git clone https://github.com/hotseatio/hotseat.io.git
cd hotseat.io

# Set up Ruby
rbenv init # follow the instructions listed
rbenv install
gem install bundler
bundle install

# Set up Node.js
nodenv init # follow the instructions listed
nodenv install
yarn

# Set up pre-commit hooks
pre-commit install

# Set up the database
# (Get the database dump file from the Slack)

# This will fail if you haven't set up the hotseat_dev db before. You can skip if so!
dropdb hotseat_dev
createdb hotseat_dev
psql -f path/to/dump.sql -d hotseat_dev # replace the path!
# You can ignore any error messages you see when loading the dump

# Set up dev.hotseat.io
echo -e "# Hotseat dev server\n127.0.0.1 dev.hotseat.io" | sudo tee -a /etc/hosts

# Start the server
bin/dev
```

You may run into errors if you don't have a `.env.development.local` in the root directory. This is because the following environment variables are not provided:

- `STRIPE_PUBLIC_KEY`
- `STRIPE_PRIVATE_KEY`
- `STRIPE_SIGNING_SECRET`
- `GOOGLE_CLIENT_ID`
- `GOOGLE_CLIENT_SECRET`

If you're in DevX, let Nathan know and he can share some test keys with you!

### Setup Tests

In a separate terminal, run the following:

```
bin/rails test:all
cd lambdas/ && make test
```

## Development

### Starting the server

You can start the server with:

```sh
bin/dev
```

This will start both the Rails backend and the JavaScript frontend.

You can visit your local Hotseat development site at http://dev.hotseat.io:3000 or http://localhost:3000.

### Debugging

We use [debug](https://github.com/ruby/debug) for debugging. Simply drop a `debugger` and get an interactive prompt. To connect to the debugger, run:

```
rdbg -a
```

### Entity Diagram

```
bundle exec erd
```

![](docs/entity-relationship-diagram.png)

### Typechecking with Sorbet

Ruby is a dynamically typed language. Static type-checking is not something built-in by default. We use a library called [Sorbet](https://sorbet.org) to typecheck our code. Sorbet has a number of editor integrations, you can also typecheck with:

```sh
rake sorbet:typecheck
```

If you update a model, install a new gem, run a migration, or update a route, you'll also have to update the types.

```sh
rake sorbet:update:all
```

### Writing Tests

#### Ruby

We use Minitest and FactoryBot for our testing.

You can run tests with the following:

```sh
bin/rails test # run all tests (excluding system tests)
bin/rails test:system # run system tests
bin/rails test:all # run all tests (including system tests)
```

#### JavaScript/React

We test React components via Jest. Tests should be of the form `spec/javascript/*.spec.{js,ts,jsx,tsx}`. You can run all tests with:

```
yarn test
```

## Organization

Hotseat is a basic Rails app and follows Rails conventions for the most part. The lambda functions are stored in `lambdas/`; they contain their own documentation.
