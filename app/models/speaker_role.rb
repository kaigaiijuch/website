# frozen_string_literal: true

# == Schema Information
#
# Table name: speaker_roles
#
#  name :string           not null
#
# Indexes
#
#  index_speaker_roles_on_name  (name) UNIQUE
#
class SpeakerRole < ApplicationRecord
end
