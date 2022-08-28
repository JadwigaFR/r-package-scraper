# frozen_string_literal: true

# For a given package name and version, fetches the latest information and updates the database
class PackageWorker
  include Sidekiq::Worker

  def perform(package_object)
    package_url = CranServer.package_url(package_object[:name], package_object[:version])
    package_data = PackageScraper.new(package_url, package_object[:name]).fetch_package_data!
    PackageUpdateService.new(package_object[:name], package_data).call!
  end
end
