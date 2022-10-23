## Description

<!--- What this PR does, why we're making it, etc. -->

## Deployment

- [ ] I am making a frontend change, which will be auto-deployed via Heroku.
- [ ] I am making a Ruby change, which will be auto-deployed via Heroku.
  - [ ] I have added one or more gems, and run `rake sorbet:update:all` to generate their types.
  - [ ] I have added or changed a model, and run `rake sorbet:update:all` to generate their types.
- [ ] I am making a database change, which I will manually deploy after my branch is merged.
  - [ ] I have migrated the database using `env RAILS_ENV=production rails db:migrate`.
  - [ ] I have updated the entity relationship diagram via `bundle exec erd`.
  - [ ] I have updated the affected Administrate model dashboards to reflect my DB changes.
- [ ] I am making a Go Lambda change, which I will manually deploy after my branch is merged.
  - [ ] I have deployed the lambdas using `make deploy`.
- [ ] There are other deployment steps I must take after merge, which are:
