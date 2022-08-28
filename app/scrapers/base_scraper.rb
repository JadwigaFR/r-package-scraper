# frozen_string_literal: true

require 'open-uri'
require 'deb_control'

# Scraper to inherit from for shared logic
class BaseScraper
  attr_reader :url

  def initialize(url, opts = {})
    @url = url
    @opts = opts
  end

  private

  def destroy_file
    File.delete(file_path) if File.exist?(file_path)
  end
end
