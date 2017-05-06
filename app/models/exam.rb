class Exam < ApplicationRecord
  belongs_to :discipline
  has_many :students, through: :assessments
end
