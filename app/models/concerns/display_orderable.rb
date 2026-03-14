# frozen_string_literal: true

module DisplayOrderable
  extend ActiveSupport::Concern

  def self.with_uniqueness_scope(attribute_name)
    attribute_name = attribute_name.to_sym
    Module.new do
      extend ActiveSupport::Concern
      include DisplayOrderable

      included do
        validates attribute_name, uniqueness: { scope: :display_order }
      end
    end
  end

  included do
    validates :display_order, presence: true, numericality: { only_integer: true, greater_than: 0 }
    default_scope { order(display_order: :asc) }
  end
end
