class LessonsController < ApplicationController
  before_action :set_kindergarten
  before_action :set_lesson, only: [:edit, :update, :show, :destroy]

  def index
    @lessons = @kindergarten.lessons
  end

  def new
    @lesson = @kindergarten.lessons.new
  end

  def create
    @lesson = @kindergarten.lessons.new(lesson_params)
    if @lesson.save
      flash[:success] = 'Lesson Created!'
      redirect_to kindergarten_lesson_path(@kindergarten, @lesson)
    else
      flash[:error] = 'Fix errors and try again'
      render :new
    end
  end


  def edit
  end

  def update
    if @lesson.update(lesson_params)
      flash[:success] = 'Lesson Updated!'
      redirect_to kindergarten_lesson_path(@kindergarten, @lesson)
    else
      flash[:error] = 'Fix errors and try again'
      render :edit
    end
  end

  def show
  end

  def destroy
    @lesson.destroy
    flash[:success] = 'Lesson Successfully Deleted!'
    redirect_to kindergarten_lesson_path(@kindergarten)
  end

  private
  def lesson_params
    params.require(:lesson).permit(:subject, :teacher, :bully, :bullied)
  end

  def set_lesson
    @lesson = Lesson.find(params[:id])
  end

  def set_kindergarten
    @kindergarten = Kindergarten.find(params[:kindergarten_id])
  end

end
