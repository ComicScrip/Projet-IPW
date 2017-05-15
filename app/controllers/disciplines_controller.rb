class DisciplinesController < ApplicationController
  before_action :set_discipline, only: [:show, :edit, :update, :destroy]

  # GET /disciplines
  def index
    @disciplines = current_user.teached_disciplines
  end

  # returns a json containing an array of all students, with the key 'selected' set to true if the user studies this discipline
  def get_students_for_discipline
    d = Discipline.find(params[:discipline_id])
    students = User.with_role(:student).where(:approved => true).map { |user|
      {
          id: user.id,
          text: user.firstName + ' ' + user.lastName,
          selected: user.studied_disciplines.exists?(d.id)
      }
    }

    render :json => students
  end

  # GET /disciplines/new
  def new
    @discipline = Discipline.new
  end

  # GET /disciplines/1/edit
  def edit

  end

  # GET /disciplines/1/edit_students
  def edit_students
    @discipline = Discipline.find(params[:discipline_id])
  end

  # POST /disciplines
  def create
    @discipline = Discipline.new(discipline_params)
    @discipline.owner = current_user

    if @discipline.save
      redirect_to disciplines_path, notice: 'La matière a été crée avec succès.'
    else
      render 'new'
    end
  end

  # PATCH/PUT /disciplines/1
  def update
    if @discipline.update(discipline_params)
      redirect_to disciplines_path, notice: 'La matière a bien été mise à jour.'
    else
      render 'edit'
    end
  end

  def update_students
    d = Discipline.find(params[:discipline_id])
    students = params[:selectedStudentsIds]
    d.students.clear
    d.students = User.find(students) unless students.empty?
    render status: :ok, json: {status: 200}
  end

  # DELETE /disciplines/1
  def destroy
    current_user.teached_disciplines.delete(@discipline)
    redirect_to disciplines_url, notice: 'La matière a bien été supprimée'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_discipline
      @discipline = Discipline.find(params[:id])
    end

    # Never trust parameters from the scary intern  # DELETE /disciplines/1.jsonet, only allow the white list through.
    def discipline_params
      params.require(:discipline).permit(:name, :beginsOn, :endsOn)
    end
end
