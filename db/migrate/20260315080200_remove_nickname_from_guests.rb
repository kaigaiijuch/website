# frozen_string_literal: true

class RemoveNicknameFromGuests < ActiveRecord::Migration[7.1]
  def change
    remove_column :guests, :nickname, :string, null: false
  end
end
