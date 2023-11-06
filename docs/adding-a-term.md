# Adding a term

1. Scrape the enrollment appointments
2. Scrape the subject areas, courses, and sections

## Scrape the enrollment appointments

Every quarter, the UCLA registrar publishes the enrollment appointments for the next quarter. We download this page/file manually and scrape it in order to calculate when enrollment is.

Check out the enrollment appointment [readme](/lib/scrapedata/enrollment_appointments/README.md) for more detail on how to download and scrape this file.

## Scrape the subject areas, courses, and sections

Go to the `lambdas/` directory and update the `currentTerm` payload to match the new term. Make sure that the `term` and `id` match the database!

Once this update is made, run `make deploy` to deploy the lambdas on the new schedule. You may also want to run `fetch-subject-areas` and `fetch-courses` manually so that `fetch-sections` has all the data it needs on a run.
