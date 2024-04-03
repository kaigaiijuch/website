# frozen_string_literal: true

class CreateEpisodeTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :episode_types do |t|
      t.string :name, index: { unique: true }, null: false

      t.timestamps
    end

    add_reference :episodes, :type, foreign_key: { to_table: :episode_types }, null: false # rubocop:disable Rails/NotNullColumn
  end
end
