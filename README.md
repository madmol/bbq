# BBQ

## Description 

Application allows you invite friends to various type of actions(bbq, cinema, festival, etc). User create event with descritpion, date and location and after other user can subscribe to the event.

The application has functionality: 

* Authorization, authentification - Devise, Pundit
* OAuth - GitHub, Yandex
* File Downloading - Carrierwave
* Mail sending - ActionMailer, Sendmail
* Background tasks - ActiveJob, Resque, Redis
* Layout - Bootstrap4

## Preview

[http://bbqer.ru/](http://bbqer.ru/)

## Installation

Application uses Ruby 2.7.1 and Rails 6.0.3. Also Redis needs to be installed on the system.

```
$ git clone git@github.com:madmol/bbq.git
$ cd ./bbq
$ bundle install --without production
$ yarn install --check-files
$ cp config/databese.yml.example config/databese.yml
$ rails db:migrate
```

## Running Application

1. terminal tab: `$ bin/webpack-dev-server`
2. terminal tab: `$ bundle exec rails s`
3. terminal tab: `$ QUEUE=bbq* bundle exec rake environment resque:work`

Your application is running at: http://localhost:3000/
