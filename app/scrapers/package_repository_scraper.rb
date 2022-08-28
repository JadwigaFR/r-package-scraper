# frozen_string_literal: true

require 'open-uri'
require 'deb_control'

class PackageRepositoryScraper
  attr_reader :url

  def initialize(url)
    @url = url
  end

  def fetch_packages!
    create_local_file
    packages = parse_packages
    destroy_file
    packages
  end

  private

  def create_local_file
    File.open(file_path, 'wb') do |temp_file|
      URI.open(url) do |remote_file|
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

  def destroy_file
    File.delete(file_path) if File.exist?(file_path)
  end
end
