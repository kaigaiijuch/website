# frozen_string_literal: true

class RenameFromShortSummaryToSummaryOnEpisodes < ActiveRecord::Migration[7.1]
  def change
    rename_column :episodes, :short_summary, :summary
  end
end
