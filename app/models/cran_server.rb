# frozen_string_literal: true

require 'uri'
require 'active_model'

class CranServer
  include ActiveModel::Validations

  validates :url, presence: true
  validate :valid_url?

  attr_reader :url

  def initialize(url)
    @url = url
  end

  private

  def valid_url?
    uri = URI.parse(url)
    errors.add(:base, 'URL must be valid') unless uri.is_a?(URI::HTTP) && !uri.host.nil?
  rescue URI::InvalidURIError
    false
  end
end
