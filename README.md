# Testing starter (Kysely + MySQL + Podman)

A minimal setup for testing your [Kysely](https://kysely.dev/) queries against

1. a temporary [MySQL](https://www.mysql.com/) instance on your machine--no 3rd parties, no manual setups. Run your tests once when you feel like it, or watch them continuously.
2. a temporary MySQL instance on [GitHub Actions](https://docs.github.com/en/actions). Each commit will be checked for failing tests. Neat.

# Prerequisites

- [Node.js](https://nodejs.org/en) 20+ (we need the built-in test runner)
- [Podman](https://podman.io/) (similar to Docker, but needs no super-user privileges)

# Quick start

```console
# clone the repository
git clone https://github.com/twiddler/kysely-mysql-tests-starter.git
cd kysely-mysql-tests-starter

# install dependencies
corepack enable
corepack install
pnpm install

# run the tests once
pnpm test

# watch tests (abort with Ctrl+C)
pnpm run test:watch
```

# How it works

`pnpm test` and `pnpm run test:watch` use these building blocks for running tests on your machine:

- `scripts/start.sh`: Spins up a MySQL container with Podman and waits for its `mysqld` to get ready for being queried. We run this before our tests.
- `scripts/stop.sh`: Cleans up the container. We run this after our tests.
- `scripts/watch.sh`: Makes sure that aborting `pnpm run test:watch` with <kbd>Ctrl</kbd>+<kbd>C</kbd> stops the Podman container, too.

Additionaly, `.github/workflows` makes GitHub run your tests against a temporary MySQL database in a [GitHub service container](https://docs.github.com/en/actions/use-cases-and-examples/using-containerized-services/about-service-containers) on every commit.

# Kysely, but no TypeScript?

Kysely is my favorite query builder as of now, but I'd like to spare us the TypeScript setup and focus on MySQL and podman.
