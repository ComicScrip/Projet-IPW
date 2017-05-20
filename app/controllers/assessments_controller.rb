class AssessmentsController < ApplicationController
  before_action :set_assessment, only: [:show, :edit, :update, :destroy]

  def get_student_grades
    @student = current_user
    @assessments_by_discipline = []
    discipline_means = []
    @student.studied_disciplines.each do |d|
      discipline_grades = []
      d_hash = {
          name: d.name,
          teacher: d.owner.firstName +  ' ' + d.owner.lastName,
          teacher_email: d.owner.email,
          exams: []
      }

      d.exams.each do |e|
        a = Assessment.find_or_create_by(student: @student, exam: e)
        e_hash = {
            title: e.title,
            date: e.date,
            my_grade: a.grade
        }
        d_hash[:exams] << e_hash
        discipline_grades << a.grade if a.grade
      end

      unless discipline_grades.empty?
        d_mean = discipline_grades.inject{|sum, grade| sum + grade}.to_f / discipline_grades.size
        d_hash[:mean] = d_mean
        discipline_means << d_mean
      end

      @assessments_by_discipline << d_hash
    end

    @general_mean = nil
    @general_mean = discipline_means.inject{|sum, grade| sum + grade}.to_f / discipline_means.size unless discipline_means.empty?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assessment
      @assessment = Assessment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def assessment_params
      params.require(:assessment).permit(:grade, :user_id)
    end
end
