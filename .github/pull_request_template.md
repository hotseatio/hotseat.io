## Description

<!--- What this PR does, why we're making it, etc. -->

## Deployment

- [ ] I am making a frontend change, which will be auto-deployed.
- [ ] I am making a Ruby change, which will be auto-deployed.
  - [ ] I have added one or more gems, and run `rake sorbet:update:all` to generate their types.
  - [ ] I have added or changed a model, and run `rake sorbet:update:all` to generate their types.
- [ ] I am making a database change.
  - [ ] I have updated the entity relationship diagram via `bundle exec erd`.
- [ ] I am making a Go Lambda change, which I will manually deploy after my branch is merged.
  - [ ] I have deployed the lambdas using `make deploy`.
- [ ] There are other deployment steps I must take after merge, which are:
