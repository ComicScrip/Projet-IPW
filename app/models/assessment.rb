class Assessment < ApplicationRecord
  belongs_to :student, class_name: 'User'
  belongs_to :exam

  validates :grade, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 20}, allow_nil: true

  after_update :mail_student_when_graded

  def mail_student_when_graded
    if self.grade != self.grade_was
      UserMailer.student_has_grade(self.student, self.exam).deliver
    end
  end
end
