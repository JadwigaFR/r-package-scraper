# frozen_string_literal: true

# Service taking care of mapping the parsed information from the cran server to our package model
class PackageUpdateService
  attr_reader :name, :data

  def initialize(name, data)
    @name = name
    @data = data
  end

  def call!
    package = Package.find_or_create_by(name: name)
    attributes = attributes_mapping
    result = package.update(attributes)

    { success: result, errors: package.errors.messages }
  end

  private

  def attributes_mapping
    {
      title: data['Title'],
      version: data['Version'],
      publication_date: data['Date/Publication'],
      authors: data['Author'],
      licence: data['License'],
      dependencies: dependencies,
      r_version: r_version,
      maintainers: data['Maintainer']
    }
  end

  def r_version
    return unless data['Depends']

    regexp = /\(([^)]+)\)/
    dependency_array.first.scan(regexp).flatten.first
  end

  def dependencies
    return unless data['Depends']
    return unless dependency_array.one?

    dependency_array[(1..-1)].join(',').strip
  end

  def dependency_array
    data['Depends'].split(',')
  end
end
