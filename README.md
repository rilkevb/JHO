# JHO 

*Your job hunt, organized.* See the Angular client repository [here](https://github.com/rilkevb/JHO_Angular_Experimentation).

[![Circle CI](https://circleci.com/gh/mtvillwock/jho.svg?style=svg&circle-token=:61c1a903f8b4b59801920e70480195dbc7295f69)](https://circleci.com/gh/mtvillwock/jho)

![JHO screenshot](./dbc-mixer-jho.png)

## Test Drive

1. `git clone https://github.com/mtvillwock/JHO.git` - clone down local copy of API
1. `cd JHO` - change directory
2. `bundle install` - install gems / dependencies
3. `rake db:create` - create database
4. `rake db:migrate` - migrate database tables
3. `rails s` - start server
4. Use the [client repo](https://github.com/mtvillwock/JHO_Angular_Experimentation) to interact with the API.

## Implemented:

- Rails API [deployed](https://jho.herokuapp.com) on Heroku
- Rspec testing coverage: 1193 / 1199 LOC (99.5%) covered. (via SimpleCov, as of 09/01/15)

## Pending:

- Angular Client features (in progress)
- Angular unit testing with Karma and Jasmine
- mobile-first responsive design (in progress)
- Database indexing
- API namespacing and consequent test refactor
- External API calls or data scraping

Built with love using:

- [Ruby on Rails](http://rubyonrails.org/)
- [AngularJS](https://angularjs.org/)
- [Heroku](https://heroku.com/)

Configuration Settings and Use:
- Ruby version: ```2.0.0-p353```
- System dependencies: see ```Gemfile```
- Database creation: ```bundle exec rake db:create```
- How to run the test suite: ```bundle exec rspec```
- Services (job queues, cache servers, search engines, etc.): Pending
