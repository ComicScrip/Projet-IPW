class Exam < ApplicationRecord
  belongs_to :discipline, required: true
  has_many :students, through: :assessments

  validates :title, presence: true

  def self.belonging_to_teacher(t)
    Exam.includes(:discipline).where(discipline: t.teached_disciplines)
        .order('"disciplines"."beginsOn" DESC').references('disciplines.beginsOn')
  end
end
