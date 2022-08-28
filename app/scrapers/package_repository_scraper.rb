# frozen_string_literal: true

require_relative 'base_scraper'
# Scraper that fetches and parses a list of packages
class PackageRepositoryScraper < BaseScraper
  def fetch_packages!
    create_local_file
    packages = parse_packages
    destroy_file
    packages
  end

  private

  def create_local_file
    File.open(file_path, 'wb') do |temp_file|
      URI.parse(url).open do |remote_file|
        file = Zlib::GzipReader.new(remote_file).read
        temp_file.write(file)
      end
    end
  end

  def parse_packages
    parsed_file = DebControl::ControlFileBase.read(file_path)
    parsed_file.paragraphs.each_with_object([]) do |package, array|
      name = package['Package']
      version = package['Version']
      array << { name:, version: }
    end
  end

  def file_path
    @file_path || 'tmp/PACKAGES.tar'
  end
end
