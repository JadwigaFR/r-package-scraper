# frozen_string_literal: true

class UpdatePackagesWorker
  include Sidekiq::Worker

  def perform
    packages_url = CranServer.packages_url
    packages = PackageRepositoryScraper.new(packages_url).fetch_packages!
    packages.each { |package_object| PackageWorker.new.perform(package_object) }
  end
end
