# frozen_string_literal: true

require 'dotenv'
require 'standalone_migrations'

Dotenv.load
ENV['SCHEMA'] = File.join(ActiveRecord::Tasks::DatabaseTasks.db_dir, 'schema.rb')
StandaloneMigrations::Tasks.load_tasks
