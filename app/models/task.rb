class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 200 }

  scope :pending, -> { where(done: false) }
  scope :completed, -> { where(done: true) }
end
