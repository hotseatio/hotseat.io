# Fetch Subject Areas

Fetch Subject Areas is a simple Go function that extracts the list of currently offered subject areas from the UCLA registrar.

## Requirements

- AWS CLI already configured with Administrator permission
- [Docker installed](https://www.docker.com/community-edition)
- [Golang](https://golang.org)

## Setup process

### Installing dependencies

This project uses Go modules, so dependencies should just work.

### Building

Golang is a statically compiled language, meaning that in order to run it you have to build the executable target.

You can issue the following command in fish to build it:

```shell
make build
```
