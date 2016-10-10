Rails simple instagram clone
===

[![Build Status](https://travis-ci.org/max-borisov/rails-simple-instagram.svg?branch=master)](https://travis-ci.org/max-borisov/rails-simple-instagram) [![Code Climate](https://codeclimate.com/github/max-borisov/rails-simple-instagram/badges/gpa.svg)](https://codeclimate.com/github/max-borisov/rails-simple-instagram) [![Test Coverage](https://codeclimate.com/github/max-borisov/rails-simple-instagram/badges/coverage.svg)](https://codeclimate.com/github/max-borisov/rails-simple-instagram/coverage)

## [Demo on heroku](https://rails-simple-instagram.herokuapp.com/)

## Description
Simple instagram clone app based on Rails framework.

Inspired by [devwalks tutorial](http://www.devwalks.com/lets-build-instagram-in-rails-part-1/)

### Functionality
* Create new account, login in to system
* Create/delete comments

## Reqirements
* Ruby 2.2.2
* Rails 4.2.3

## Installation
* Clone the repo
* Run `rake db:migrate`
* Run `rake db:seed` to fill in the database
* Start the server `rails s -p 9595`
* Go to [http://localhost:9595](http://localhost:9595) and have a fun

There are 3 predefined users accounts:
* `tom@gmail.com`
* `jack@gmail.com`
* `matt@gmail.com`

The password is **11111111**

## Testing
* Run `rspec spec/`

---

![Simple ToDo lists preview](https://github.com/max-borisov/rails-simple-instagram/blob/master/app-preview.png)
