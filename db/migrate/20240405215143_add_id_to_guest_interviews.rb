# frozen_string_literal: true

class AddIdToGuestInterviews < ActiveRecord::Migration[7.1]
  def change
    add_column :guest_interviews, :id, :primary_key # rubocop:disable Rails/DangerousColumnNames
  end
end
