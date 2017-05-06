class Discipline < ApplicationRecord
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'
  has_and_belongs_to_many :students, class_name: 'User'
  has_many :exams
end
