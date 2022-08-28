# frozen_string_literal: true

require 'sidekiq'
# For a given package name and version, fetches the latest information and updates the database
class PackageWorker
  include Sidekiq::Worker

  def perform(package_name, package_version)
    package_url = CranServer.package_url(package_name, package_version)
    package_data = PackageScraper.new(package_url, package_name).fetch_package_data!
    PackageUpdateService.new(package_name, package_data).call!
  end
end
