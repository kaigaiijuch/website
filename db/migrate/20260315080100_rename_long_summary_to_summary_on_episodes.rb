# frozen_string_literal: true

class RenameLongSummaryToSummaryOnEpisodes < ActiveRecord::Migration[7.1]
  def change
    rename_column :episodes, :long_summary, :summary
  end
end
