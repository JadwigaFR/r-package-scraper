# frozen_string_literal: true

require './app/workers/update_packages_worker'
require './app/models/cran_server'
require './app/scrapers/package_repository_scraper'
require './app/workers/package_worker'

RSpec.describe UpdatePackagesWorker do
  describe '#perform' do
    let(:packages) { [{ name: 'A3', version: '1.0.0' }, { name: 'A4', version: '1.0.0' }] }
    subject { described_class.new.perform }

    before do
      allow(PackageRepositoryScraper).to receive(:new).and_call_original
      allow_any_instance_of(PackageRepositoryScraper).to receive(:fetch_packages!).and_return(packages)
      allow(PackageWorker).to receive(:perform_async)
    end

    it 'calls the package repository scraper' do
      subject
      expect(PackageRepositoryScraper).to have_received(:new).with('http://cran.r-project.org/src/contrib/PACKAGES.gz')
    end

    it 'calls the package worker twice' do
      subject
      expect(PackageWorker).to have_received(:perform_async).twice
    end
  end
end
