class UserMailer < ApplicationMailer
  def user_was_approved(user)
    @user = user
    mail(to: @user.email, subject: 'Assessme - Votre compte vient d\'être activé !')
  end

  def student_has_grade(student, exam)
    @student = student
    @exam = exam
    mail(to: student.email, subject: 'Assessme - vous avez été noté pour l\'examen ' + exam.title + ' (' + exam.discipline.name + ')')
  end

end