class Task < ApplicationRecord
  validates :title, presence: true
  validate :deadline_is_date?

  private

  def deadline_is_date?
    unless deadline.is_a?(Date)
      errors.add(:deadline, 'must be in a format of YYYY-MM-DD')
    end
  end
end
