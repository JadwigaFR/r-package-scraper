# frozen_string_literal: true

class PackageWorker
  include Sidekiq::Worker

  def perform(package_object)
    url = CranServer.package_url(package_object[:name], package_object[:version])
    package_data = PackageScraper.new(url, package_object[:name]).fetch_package_data!
    PackageUpdateService(name: package_name, data: package_data).call!
  end
end
