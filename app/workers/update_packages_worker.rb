# frozen_string_literal: true

require 'sidekiq'
# Fetches the list of packages and calls another async worker to parse each package individually
class UpdatePackagesWorker
  include Sidekiq::Worker

  def perform
    packages_url = CranServer.packages_url
    packages = PackageRepositoryScraper.new(packages_url).fetch_packages!
    # packages.each { |package_hash| PackageWorker.perform_async(package_hash[:name], package_hash[:version]) }
    package_hash = packages.first
    PackageWorker.new.perform(package_hash[:name], package_hash[:version])
    # packages.each do |package_hash|
    #   binding.pry
    #   PackageWorker.perform_async(package_hash[:name], package_hash[:version])
    # end
  end
end
