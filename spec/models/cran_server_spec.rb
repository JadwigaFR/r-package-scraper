# frozen_string_literal: true

require './app/models/cran_server'

RSpec.describe CranServer, type: :model do
  describe '#valid?' do
    subject { described_class.new(url).valid? }

    context 'with a valid url' do
      let(:url) { 'https://cran.r-project.org/src/contrib/' }
      it { expect(subject).to be true }
    end

    context 'with an invalid url' do
      let(:url) { 'htt://cran.r-prozect.org/src/controb/' }
      it { expect(subject).to be false }
    end
  end
end
