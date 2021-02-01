# frozen_string_literal: true

class Event < ApplicationRecord
  validates :title, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true

  belongs_to :author, class_name: 'User'
end
