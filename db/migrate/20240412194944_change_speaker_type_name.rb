# frozen_string_literal: true

class ChangeSpeakerTypeName < ActiveRecord::Migration[7.1]
  def change
    remove_column :speakers, :global_id, :string, null: false

    add_column :speakers, :type_name, :string, null: false, default: 'host'
    change_column_default :speakers, :type_name, from: 'host', to: nil

    add_foreign_key :speakers, :speaker_types, column: :type_name, primary_key: :name
  end
end
