# frozen_string_literal: true

class UpdatePackagesWorker
  include Sidekiq::Worker

  def perform
    scraper = PackageRepositoryScraper.new(CranServer.packages_url)

    packages = scraper.fetch_packages!

    packages.each do |package_object|
      url = CranServer.package_url(package_object[:name], package_object[:version])
      PackageWorker.perform_async(url, package_object[:name])
    end
  end
end
