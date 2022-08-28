# README
This repository was created to fulfill Latana's coding challenge

## Dependencies
- ruby `3.1.2`
- postgresql

## How to set up
- Install dependencies `bundle install`
- Make a copy of `env.sample.yml` and create `.env` file
- Create database: `rake db:create`

## How to use
- Launch sidekiq `bundle exec sidekiq -e ${RACK_ENV:-development} -r ./config/application.rb -C ./config/sidekiq.yml`
- Or launch the worker directly from a `console` with `UpdatePackagesWorker.new.perform`

## How to test
- Prepare tests database: `rake db:test:prepare`
- Run test suite: `bundle exec rspec`

## Application
This simple application consist of a `UpdatePackagesWorker` whose role is to parse the main PACKAGES.gz file to get a
list of packages and their version. It will then call asynchronously the `PackageWorker` whose role is to fetch the detailed
information about the package and to store them in the database.

The application is not fully working, it's not able to parse some of the packages depending on the returned file size.

Given more time, I would work on:
- Performance! Find the best strategy for reading and writing the files asynchronously
- Error handling. I chose to not spend too much time on this as long as I couldn't get the full app working
- Package validation. Validation of the fields and maybe some better formatting.
- Package versioning. Recognize when a new version has been published of an indexed package and store new version without
overwriting already indexed one.

### Remarks
I am used to working with rails application so I wanted to challenge myself by creating a bare ruby
application. It took me a long time to work with gems I'm used to but outside the rails framework. I have 
been struggling with loading the application files properly at the right moment, I definitely need more practice with ruby
without rails apps.

I also found it challenging to work with the different file types, tars and gzs, finding a proper strategy for I/O keeping 
the performance in mind.


