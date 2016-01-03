class CarsController < ApplicationController
  before_action :logged_in_user

  def new
    @car = Car.new
  end

  def create
    @car = current_user.cars.build(car_params)
    if(@car.save)
      redirect_to root_url
    else
      render 'new'
    end
  end

  private
    def car_params
      params.require(:car).permit(:make, :model, :year, :nickname, :description )
    end
end
