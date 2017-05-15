class Assessment < ApplicationRecord
  belongs_to :student, class_name: 'User'
  belongs_to :exam

  validates :grade, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 20}, allow_nil: true
end
