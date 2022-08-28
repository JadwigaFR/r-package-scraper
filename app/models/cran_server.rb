# frozen_string_literal: true

class CranServer
  class << self
    def base_url
      'http://cran.r-project.org/src/contrib/'
    end

    def packages_url
      "#{base_url}PACKAGES.gz"
    end

    def package_url(name, version)
      "#{base_url}#{name}_#{version}.tar.gz"
    end
  end
end
