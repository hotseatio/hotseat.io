# Archived enrollment appointments data

These files are archived versions of the [enrollment appointments table](https://registrar.ucla.edu/registration-classes/enrollment-appointments/enrollment-appointments) provided by the UCLA Registrar.

The table is updated roughly every quarter to provide enrollment appointments for the next quarter.

## Adding or updating a page

```
# from root hotseat directory
curl https://registrar.ucla.edu/registration-classes/enrollment-appointments/enrollment-appointments -o lib/scrapedata/enrollment_appointments/<START_TERM>-<END_TERM>.html
```

Note that depending on the time of year, there may only be one or two terms listed on the website. In summer/fall, the fall term is only listed. In fall, both fall and winter are listed. In winter/spring, spring, winter, and fall are listed. Please name the file accordingly.

## Scraping a downloaded file

1. Make sure the file is listed in the `enrollment_appointments_map` in `lib/tasks/scrape.rake`.
2. `rake scrape:summer_session_dates[<YEAR>]`. Note that we use Fall of that year as the anchor. Example: `rake scrape:summer_session_dates[2022]` will scrape enrollment appointments from Fall 2022 to Spring 2023.
3. Confirm that the dates have been correctly added under the appropriate columns in the `enrollment_appointments` table.
