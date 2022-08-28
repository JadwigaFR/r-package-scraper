# README
This repository was created to fulfill Latana's coding challenge

## Dependencies
ruby `3.1.2`
postgresql

## How to set up
- Install dependencies `bundle install`
- Make a copy of `env.sample.yml` and create `.env` file
- Create database: `rake db:create`

## How to test
- Prepare tests database: `rake db:test:prepare`
- Run test suite: `bundle exec rspec`

## Application
This simple application consist of a `UpdatePackagesWorker` whose role is to parse the main PACKAGES.gz file to get a
list of packages and their version. It will then call asynchronously the `PackageWorker` whose role is to fetch the detailed
information about the package and to store them in the database.

The application is not working fully. Depending on the returned file size, some packages are not properly parsed.

### Thoughts
I am very much used to working with rails application so I wanted to challenge myself by creating a simple ruby
application without rails. It took me a long time to work with gems I'm used to but outside the rails framework. I have 
been struggling with loading the application files properly at the right moment, I definitely need more practice with ruby
without rails apps.

I also found it challenging to work with the different file types, tars and gzs, finding a proper strategy for I/O keeping 
the performance in mind.


