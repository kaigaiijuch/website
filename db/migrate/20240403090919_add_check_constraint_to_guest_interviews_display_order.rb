# frozen_string_literal: true

class AddCheckConstraintToGuestInterviewsDisplayOrder < ActiveRecord::Migration[7.1]
  def change
    add_check_constraint :guest_interviews, 'display_order > 0', name: 'check_display_order_positive'
  end
end
