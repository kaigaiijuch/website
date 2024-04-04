# frozen_string_literal: true

module StaticFileable
  extend ActiveSupport::Concern

  def initialize(data)
    @data = data

    @data.each_key do |key|
      self.class.define_method(key) do
        @data.fetch(key)
      end
    end
  end

  def episode_number
    @data[:episode_number]
  end

  def episode
    @episode ||= Episode.find_by(number: episode_number)
  end

  def ==(other)
    @data.each_key do |key|
      return false if @data.fetch(key) != other.public_send(key)
    end
    true
  end

  class_methods do
    def relation_class(klass)
      @relation_class = klass
    end

    def where(episode_number:)
      @relation_class.new(episode_number:)
    end
  end
end
