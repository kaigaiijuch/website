# frozen_string_literal: true

# == Schema Information
#
# Table name: hosts
#
#  id          :integer          not null, primary key
#  description :string
#  name        :string           not null
#  title       :string           not null
#  url         :string
#
class Host < ApplicationRecord
end
