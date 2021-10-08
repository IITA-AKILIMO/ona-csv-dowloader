# AKILIMO requests downloader

#### This Utility downloads application requests from the `AKILIMO` api

## Features

- Download `csv` data as `text/csv` from an endpoint and save it as a file
- Parse csv into a `dataframe`


## Tech

This tool uses a number of open source projects to work properly:

- [R](https://www.r-project.org/) - The ultimate statistical tool!

## authentication

Currently the utility used Basic authorization, we however plant to move onto more secure methods in the near future

## Setup

Sensitive information such as passwords are stored in an environment file `.env` refer to the `.env.example` for required variable names

rename the  `.env.example` to `.env`
```md
USER=
PASS=
BASE_URL=http://localhost:8098/api

```

### Changelog generation

> git-chglog -o CHANGELOG.md


## License

MIT
