# frozen_string_literal: true

require 'rubygems/package'
require_relative 'base_scraper'

# Scraper that fetches and parses the data of a given package
class PackageScraper < BaseScraper
  attr_reader :package_name

  def initialize(url, package_name)
    @url = url
    @package_name = package_name
  end

  def fetch_package_data!
    create_local_file
    # binding.pry
    package_data = parse_package
    destroy_file
    package_data
  end

  private

  def create_local_file
    File.open(file_path, 'wb') do |temp_file|
      URI.parse(url).open do |remote_file|
        unzipped = Zlib::GzipReader.open(remote_file)
        tar_folder = Gem::Package::TarReader.new(unzipped)
        file = tar_folder.seek("#{package_name}/DESCRIPTION", &:read)
        temp_file.write(file)
      end
    end
  end

  def parse_package
    parsed_file = DebControl::ControlFileBase.read(file_path)
    parsed_file.paragraphs.first.slice('Package', 'Title', 'Version', 'Author', 'Maintainer', 'Description', 'License',
                                       'Depends', 'Date/Publication')
  end

  def file_path
    @file_path || "tmp/#{package_name}.tar"
  end
end
