class CatsController < ApplicationController
  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    render :show
  end

  def new
    render :new
  end

  def create
    @cat = Cat.create(cat_params)

    if @cat.save
      redirect_to cat_url(@cat.id)
    else
      render :new
      # not good for end user, would rather show errors and retry form submission
    end
  end

  private
  def cat_params
    params.require(:cat).permit(:name, :sex, :color, :birth_date, :description)
  end
end
