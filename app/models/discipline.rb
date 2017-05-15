class Discipline < ApplicationRecord
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id', required: true
  has_and_belongs_to_many :students, class_name: 'User'
  has_many :exams

  validate :owner_must_be_a_teacher, :ends_date_must_be_after_begins_date
  validates :name, presence: true

  def owner_must_be_a_teacher
    unless owner.present? && owner.has_role?(:teacher)
      errors.add(:owner, 'Le propriétaire d\'une matière ne peut être qu\'un professeur')
    end
  end

  def ends_date_must_be_after_begins_date
    unless beginsOn.present? && endsOn.present? && beginsOn <= endsOn
      errors.add(:beginsOn, 'Le début des interventions ne peut être ultérieur à la fin des interventions')
      errors.add(:endsOn, 'Le début des interventions ne peut être ultérieur à la fin des interventions')
    end
  end
end
