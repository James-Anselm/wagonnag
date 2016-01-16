class CarsController < ApplicationController
  before_action :logged_in_user

  def index
    @user = current_user
  end

  def show
    @car = Car.find(params[:id])
  end

  def new
    @car = Car.new
  end

  def create
    @car = current_user.cars.build(car_params)
    if(@car.save)
      redirect_to @car
    else
      render 'new'
    end
  end

  def edit
    @car = Car.find(params[:id])
  end

  def update
    @car = Car.find(params[:id])
    if @car.update_attributes(car_params)
      flash[:success] = "Car updated"
      redirect_to @car
    else
      render 'edit'
    end
  end

  def destroy
    Car.find(params[:id]).destroy
    flash[:success] = "Car deleted"
    redirect_to user_path(:id => current_user.id)
  end

  private
    def car_params
      params.require(:car).permit(:make, :model, :year, :nickname, :description, :odometer )
    end
end
