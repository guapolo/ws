# Group events test app

This application was built using Rails 5.2.2, Ruby 2.5.1 and PostgreSQL.

## Setup

There's a [Dockerfile](docker/Dockerfile) for development purposes under the `docker` directory, which can be used with `docker-compose`.

To run the PostgreSQL Docker container, run `docker-compose -f docker/docker-compose.development.yml up` from this directory.

After spinning up the database Docker container, run:

```
bundle install
bundle exec rake db:setup

# Run tests with:
bundle exec rspec

# Run a Passenger server with
bundle exec passenger start
# Visit the API in http://localhost:300
```


## Notes

The API adheres to the JSON API 1.0 specification (see [http://jsonapi.org](http://jsonapi.org)).