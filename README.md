# martin-rails-6-demo

## Run it locally

#### Prerequisites

* Ruby
* yarn (or npm)
* PostgreSQL

#### Setup

```
$ git clone https://github.com/mrtnnk/martin-rails-6-demo.git
$ cd martin-rails-6-demo/
$ cp .env.example .env
$ bundle install
$ yarn install (or npm install)
$ bundle exec rake db:setup
```

#### Running

```
$ bundle exec rails s
```

Now you can visit http://localhost:3000 to play with the demo site.