# Sample Ruby API

## Sample Objectives

You will be creating a simple user management API using the tools described below.

Create API endpoints that enable the following:
1. Albums
  creating and deleting albums
  changing album details (name, artist, album art)
  adding / removing songs
  Artists (musicians/bands)
  creating and deleting artists
  changing artist details (name, bio, albums)
2. Songs
  creating and deleting songs
  changing song details (name, duration, genre, album, artist, etc)
  songs can be featured and featured songs have a here image and extra texts to describe or promote it
3. Playlists
  creating and deleting playlists
  changing playlist name
  adding / removing songs from playlist

  The API should be written in Ruby
  Rails and/or an API framework such as Grape
  The information should be stored in a database of your choice
  Document the API so a developer can understand how to use it
  Explain the architectural and design decisions you make
  Publish the code on GitHub & deploy the API so we can take a look at it
  I would like you to use your creativity to make this application as practical and realistic as possible.
  (bonus/optional) a html-based dashboard using erb, ham, or slim
  Use your creativity!

## Installation Process:

1. Install RVM (https://rvm.io/rvm/install)
2. Run `rvm install 2.3.3`
3. Run `gem install bundler`
4. Clone repository
5. `cd api-test`
6. Run `bundle install`
7. Duplicate .env.development.sample file and rename to .env.development
8. Enter correct env values for .env.development
9. Repeat steps 7 and 8 for env.test
10. To start ruby server, run `make run`

**Note:** Be sure to set database url for env.test to your test database and not your development database. Tests will truncate all tables in the test database before running!

## Libraries

### Routing

Grape: https://github.com/ruby-grape/grape

Grape Entity: https://github.com/ruby-grape/grape-entity

Grape Swagger: https://github.com/ruby-grape/grape-swagger

### Database / Models

Sequel: http://sequel.jeremyevans.net/

### Forms

Hanami: https://github.com/hanami/validations

Uses dry validation as the syntax to validate inputs. Suggested reading: http://dry-rb.org/gems/dry-validation/

### Testing

Rspec: http://www.relishapp.com/rspec/rspec-core/docs

Factory Girl: https://github.com/thoughtbot/factory_girl

Faker: https://github.com/stympy/faker

## Migrations

To create a migration: `bundle exec rake "db:migration[my_migration]"`

To code the migration: go to `application/migrate/XXXXXX_my_migration.rb` -- instructions here: https://github.com/jeremyevans/sequel/blob/master/doc/migration.rdoc

To apply the migration: `bundle exec rake db:migrate`

To apply the migration to your test database: `RACK_ENV=test bundle exec rake db:migrate`

## Running Tests

Run your tests using:

`make test`
