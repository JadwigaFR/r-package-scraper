# frozen_string_literal: true

ENV['ENVIRONMENT'] ||= 'development'

require 'pg'
require 'active_record'
require 'dotenv'
require 'yaml'
require 'erb'
require 'pry-byebug'
require 'app/models/package'
require 'app/scrapers/base_scraper'
require 'app/scrapers/package_repository_scraper'
require 'app/scrapers/package_scraper'
require 'app/services/package_update_service'

Dotenv.load(".env.#{ENV.fetch('ENVIRONMENT')}.local", ".env.#{ENV.fetch('ENVIRONMENT')}", '.env')
def db_configuration
  db_configuration_file_path = File.join(File.expand_path('..', __dir__), 'db', 'config.yml')
  db_configuration_result = ERB.new(File.read(db_configuration_file_path)).result
  YAML.safe_load(db_configuration_result, aliases: true)
end

ActiveRecord::Base.establish_connection(db_configuration[ENV['ENVIRONMENT']])

module Application
  class Error < StandardError; end

  # Your code goes here...
end
