# frozen_string_literal: true

# == Schema Information
#
# Table name: speaker_types
#
#  name :string           not null
#
# Indexes
#
#  index_speaker_types_on_name  (name) UNIQUE
#
class SpeakerType < ApplicationRecord
end
