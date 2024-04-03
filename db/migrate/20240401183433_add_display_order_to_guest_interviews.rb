# frozen_string_literal: true

class AddDisplayOrderToGuestInterviews < ActiveRecord::Migration[7.1]
  def change
    add_column :guest_interviews, :display_order, :integer, null: false, default: 1
  end
end
