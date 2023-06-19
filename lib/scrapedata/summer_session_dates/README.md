# Archived summer session dates

These files are archived versions of the [summer sessions dates table](https://registrar.ucla.edu/calendars/summer-session-calendar) provided by the UCLA Registrar.

## Adding/updating a file

To download the latest version of a file, run:

```sh
curl https://registrar.ucla.edu/calendars/summer-session-calendar -o lib/scrapedata/summer_session_dates/summer-calendar-<YEAR>.html
```

## Scraping a downloaded file

1. Make sure the file is listed in the `summer_session_dates_map` in `lib/tasks/scrape.rake`.
2. `rake scrape:summer_session_dates[<YEAR>]`. Example: `rake scrape:summer_session_dates[2022]`
3. Confirm that the dates have been correctly added under the appropriate columns in the `terms` table.
