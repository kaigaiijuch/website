# frozen_string_literal: true

class RenameSubtitleToIntroductionOnEpisodes < ActiveRecord::Migration[7.1]
  def change
    rename_column :episodes, :subtitle, :introduction
  end
end
