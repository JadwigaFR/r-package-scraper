# frozen_string_literal: true

class PackageWorker
  include Sidekiq::Worker

  def perform(cran_server_url, package_name)
    package_url = package_url(cran_server_url, package_name)
    package_data = PackageScraper.new(package_url).package_data
    PackageUpdateService(name: package_name, data: package_data).call!
  end

  private

  def package_url(cran_server_url, package_name)
    "#{cran_server_url}/#{package_name}"
  end
end
