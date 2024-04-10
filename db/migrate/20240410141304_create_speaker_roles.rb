# frozen_string_literal: true

class CreateSpeakerRoles < ActiveRecord::Migration[7.1]
  def change
    create_table :speaker_roles, id: false do |t|
      t.string :name, index: { unique: true }, null: false
    end
  end
end
