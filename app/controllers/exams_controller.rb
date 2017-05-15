class ExamsController < ApplicationController
  before_action :set_exam, only: [:show, :edit, :update, :destroy]

  # GET /exams
  def index
    @exams = Exam.belonging_to_teacher(current_user)
  end

  # GET /exams/1
  def show
  end

  # GET /exams/new
  def new
    @exam = Exam.new
  end

  # GET /exams/1/edit
  def edit

  end

  def edit_assessments
    @exam = Exam.find(params[:exam_id])
    students_for_exam = @exam.discipline.students

    @assessments = []
    students_for_exam.each { |s|
      @assessments << Assessment.find_or_create_by(student: s, exam: @exam)
    }
  end

  # POST /exams
  def create
    @exam = Exam.new(exam_params)

    if @exam.save
      redirect_to exams_path, notice: 'L\'examen a été créé avec succès.'
    else
      render 'new'
    end
  end

  # PATCH/PUT /exams/1
  def update
    if @exam.update(exam_params)
      redirect_to exams_path, notice: 'L\'examen a bien été mise à jour.'
    else
      render 'edit'
    end
  end

  def update_assessments
    assessments = params[:assessments]
    Assessment.update(assessments.keys, assessments.values)
    redirect_to exam_edit_assessments_path, notice: 'Les notes ont bien été mises à jour.'
  end

  # DELETE /exams/1
  def destroy
    @exam.destroy
    redirect_to exams_url, notice: 'L\'examen a bien été supprimé'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exam
      @exam = Exam.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def exam_params
      params.require(:exam).permit(:title, :date, :discipline_id)
    end
end
