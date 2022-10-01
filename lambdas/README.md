# Lambdas

These are the AWS Lambda functions that scrape the UCLA Registrar.

## Installation

All the Lambda functions are written in Go. You'll need:

- [Go](https://golang.org)
- [GNU Make](https://www.gnu.org/software/make/)
- [Serverless](https://www.serverless.com)
  - Node.js is a dependency of Serverless
  - Docker is required for Serverless

You can then run `make` to install any dependencies.

## Layout

Each lambda function is given its own subdirectory.

A `trigger-*` function takes a given term and creates a list of parent objects
by scanning the database. (Example: `trigger-sections` creates a list of
courses offered for a given term.) The trigger function then batches this list
and starts to invoke instances of the corresponding `fetch-*` function.

A `fetch-*` function takes a list of parent objects and uses these objects to
fetch and store the specified resource. (Example: `fetch-sections` takes a list
of courses, then retrieves these course pages, scrapes the section info for
each course, and saves the retrieved data in the database.)

## Testing

### Unit Tests

Run unit tests with

```bash
make # or make test
```

#### Fetching the mock registrar responses

We have mock responses for the registrar endpoints used in the unit tests. You
can populate the fixtures with `make fixtures`.

### Manual Tests

The functions can be tested locally using Docker, Serverless, and the `event.json`
files. To locally invoke a function, use:

```bash
make local-fetch-subject-areas # or make local-fsa
make local-trigger-courses # or make local-tc
```

## Deployment

To deploy, simply run

```bash
make deploy
```
