# frozen_string_literal: true

class AddPlaceOnEpisodes < ActiveRecord::Migration[7.1]
  def change
    add_column :episodes, :place, :string
  end
end
