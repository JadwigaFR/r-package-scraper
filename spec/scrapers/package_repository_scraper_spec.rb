# frozen_string_literal: true

require './app/scrapers/package_repository_scraper'
require './app/models/cran_server'

RSpec.describe PackageRepositoryScraper do
  describe '#fetch_packages!' do
    subject { described_class.new(CranServer.packages_url).fetch_packages! }

    context 'with a valid packages url' do
      it 'returns an array of package objects' do
        VCR.use_cassette('packages') do
          expect(subject).to be_an_instance_of(Array)
        end
      end

      it 'parses correctly packages file' do
        VCR.use_cassette('packages') do
          expect(subject.first).to eql({ name: 'A3', version: '1.0.0' })
        end
      end
    end
  end
end
