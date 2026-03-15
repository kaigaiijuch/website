# frozen_string_literal: true

class RemoveSummaryFromEpisodes < ActiveRecord::Migration[7.1]
  def change
    remove_column :episodes, :summary, :text
  end
end
