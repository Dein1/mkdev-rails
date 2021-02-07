# frozen_string_literal: true

class Event < ApplicationRecord
  include AASM

  aasm column: 'state' do
    state :pending, initial: true
    state :approved
    state :rejected

    event :approve do
      transitions from: :pending, to: :approved
    end

    event :reject do
      transitions from: :pending, to: :rejected
    end

    event :renew do
      transitions from: :rejected, to: :pending
    end
  end

  def self.resolved
    Event.where(state: %i[approved rejected])
  end

  validates :title, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true

  belongs_to :author, class_name: 'User'
end
