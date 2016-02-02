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
    old_car_odometer = @car.odometer
    count = 0
    if @car.update_attributes(car_params)
      if(old_car_odometer < @car.odometer)
        @car.maintenance_items.each do |maintenance_item|
            if(maintenance_item.interval &&
              maintenance_item.last_maintained_odometer &&
              @car.odometer > (maintenance_item.last_maintained_odometer + maintenance_item.interval))
              if(!maintenance_item.due_for_checkup)
                maintenance_item.update_due_for_checkup(true)
              end
              count = count + 1
            end
        end
      end

      flash[:success] = "Update succeeded. #{count} maintenance item(s) are due for a checkup."
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
