# frozen_string_literal: true

class AddPostalCodeToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :postal_code, :string
  end
end
