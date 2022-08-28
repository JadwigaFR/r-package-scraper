# frozen_string_literal: true

require 'rubygems/package'
require 'open-uri'
class PackageScraper
  attr_reader :url, :package_name

  def initialize(url, package_name)
    @url = url
    @package_name = package_name
  end

  def fetch_package_data!
    URI.open(url) do |remote_file|
      unzipped = Zlib::GzipReader.open(remote_file)
      tar_folder = Gem::Package::TarReader.new(unzipped)
      tar_folder.seek("#{package_name}/DESCRIPTION", &:read)
    end
  end
end
