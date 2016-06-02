# Requirements

* PostgreSQL

# Setup

1. `cp config/database.yml.example config/database.yml`
* `bundle`
* `bundle exec rake db:setup`
* `bundle exec sidekiq`

# Features

1. `Infinite scroll via ajax and jquery pagination.`
2. `Console showing progress of long CSV file parsing in background. `
3. `Recording of file parsing progress history.`
4. `Filter option`
5. `Download in CSV format`

