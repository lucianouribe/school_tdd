class SutdentsController < ApplicationController
  before_action :set_lesson
  before_action :set_sutdent, only: [:edit, :update, :show, :destroy]

  def index
    @sutdents = @lesson.sutdents
  end

  def new
    @sutdent = @lesson.sutdents.new
  end

  def create
    @sutdent = @lesson.sutdents.new(sutdent_params)
    if @sutdent.save
      flash[:success] = 'Student created!'
      redirect_to lesson_sutdent_path(@lesson, @sutdent)
    else
      flash[:error] = 'Failed to create!'
      redirect_to :new
    end
  end

  def edit
  end

  def update
    if @sutdent.update(sutdent_params)
      flash[:success] = 'Sutdent Updated!'
      redirect_to lesson_sutdent_path(@lesson, @sutdent)
    else
      flash[:error] = 'Failed to update!'
      render :edit
    end
  end

  def show
  end

  def destroy
    @sutdent.destroy
    flash[:success] = 'Sutdent Successfully Deleted!'
    redirect_to lesson_sutdents_path(@lesson)
  end

  private
  def sutdent_params
    params.require(:sutdent).permit(:name, :behaves)
  end

  def set_sutdent
    @sutdent = Sutdent.find(params[:id])
  end

  def set_lesson
    @lesson = Lesson.find(params[:lesson_id])
  end

end
