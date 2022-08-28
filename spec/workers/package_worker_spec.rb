# frozen_string_literal: true

require './app/models/cran_server'
require './app/workers/package_worker'
require './app/scrapers/package_scraper'
require './app/services/package_update_service'

RSpec.describe PackageWorker do
  describe '#perform' do
    let(:name) { 'ABPS' }
    let(:version) { '0.3' }
    let(:package_data) {{ Package: 'ABPS', Title: 'Great package that does things', Versions: '0.3'}}
    subject { described_class.new.perform(name, version) }

    before do
      allow(PackageScraper).to receive(:new).and_call_original
      allow(PackageUpdateService).to receive(:new).and_call_original
      allow_any_instance_of(PackageUpdateService).to receive(:call!)
    end

    it 'calls the package scraper' do
      VCR.use_cassette('package') do
        expect_any_instance_of(PackageScraper).to receive(:fetch_package_data!).once
        subject
        expect(PackageScraper).to have_received(:new).with("http://cran.r-project.org/src/contrib/#{name}_#{version}.tar.gz", name)
      end
    end

    it 'calls the package scraper' do
      VCR.use_cassette('package') do
        allow_any_instance_of(PackageScraper).to receive(:fetch_package_data!).and_return(package_data)
        subject
        expect(PackageUpdateService).to have_received(:new).with(name, package_data)
      end
    end
  end
end
