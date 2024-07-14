# frozen_string_literal: true

class DropNotNullFromEpisodesSummary < ActiveRecord::Migration[7.1]
  def change
    change_column_null :episodes, :summary, true
  end
end
