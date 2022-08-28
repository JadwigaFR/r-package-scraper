# frozen_string_literal: true

require './app/scrapers/package_scraper'
require './app/models/cran_server'

RSpec.describe PackageScraper do
  let(:name) { 'ABPS'}
  let(:version) { '0.3'}

  describe '#fetch_packages!' do
    subject { described_class.new(CranServer.package_url(name, version), name).fetch_package_data! }

    context 'with a valid packages url' do
      it 'returns a description string' do
        VCR.use_cassette('package') do
          expect(subject).to be_a_kind_of(String)
        end
      end

      it 'parses correctly packages file' do
        VCR.use_cassette('package') do
          expect(subject).to include("Package: #{name}")
          expect(subject).to include("Version: #{version}")
        end
      end
    end
  end
end
