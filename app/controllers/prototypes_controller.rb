class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]

  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end

    def show
      @prototype = Prototype.find(params[:id])
      @comment = Comment.new
      @comments = Comment.all
    end

    def edit
      unless user_signed_in?
        redirect_to action: :index
      else
      @prototype = Prototype.find(params[:id])
      end
    end

    def update
      @prototype = Prototype.find(params[:id])
      if @prototype.update(prototype_params)
        redirect_to root_path
      else
        render :edit
      end
    end

    def destroy
      @prototype = Prototype.find(params[:id])
      @prototype.destroy
      redirect_to root_path
    end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image, :user).merge(user_id: current_user.id)
  end
end

