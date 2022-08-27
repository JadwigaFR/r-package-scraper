# frozen_string_literal: true

class UpdatePackagesWorker
  include Sidekiq::Worker

  def perform
    cran_server = CranServer.new(url: cran_server_url)

    packages = PackageRepositoryScraper.new(url: cran_server.url).fetch_packages!

    packages.each do |package|
      PackageWorker.perform_async(cran_server.url, package)
    end
  end
end
