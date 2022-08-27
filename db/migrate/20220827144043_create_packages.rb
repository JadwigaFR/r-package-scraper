# frozen_string_literal: true

class CreatePackages < ActiveRecord::Migration[7.0]
  def change
    create_table :packages do |t|
      t.string :name
      t.string :version
      t.string :r_version
      t.string :dependencies
      t.date :publication_date
      t.string :title
      t.string :authors
      t.string :maintainers
      t.string :licence

      t.timestamps
    end
  end
end
