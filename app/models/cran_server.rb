# frozen_string_literal: true

class CranServer
  attr_reader :url

  def initialize(url:)
    @url = url
  end

  #  add validation to ensure it's a valid url with a package list
end
