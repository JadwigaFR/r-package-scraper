# frozen_string_literal: true

require './app/workers/update_packages_worker'

RSpec.describe UpdatePackagesWorker do
  describe 'perform' do
    subject { described_class.perform(cran_server_url) }

    it 'calls'
  end
end
