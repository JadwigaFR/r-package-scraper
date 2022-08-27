# frozen_string_literal: true

require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

$LOAD_PATH.unshift File.join(File.dirname(__FILE__), '..')

Dir.glob(File.join(File.dirname(__FILE__), 'app/**/*.rb')).each do |file_name|
  load(file_name)
end
