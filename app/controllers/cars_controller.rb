class CarsController < ApplicationController
  include MaintenanceItemsHelper

  before_action :logged_in_user

  def index
    @user = current_user
  end

  def show
    @car = Car.find(params[:id])
  end

  def new
    @user = current_user
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
      count = update_maintenance_items()
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

  def get_update_odometer_form
    @car = Car.find(params[:id])
    if(@car && @car.user_id == current_user.id)

      respond_to do |format|
        format.js
      end
    end
  end

  def update_odometer
    @car = Car.find(params[:car_id])
    if(@car && @car.user_id == current_user.id && (Integer(params[:odometer]) rescue false))
      if(@car.update_attributes(:odometer => params[:odometer]))
        update_maintenance_items()
        @expired_maintenance_items = expired_maintenance_items(@car.user_id)
      end
    end
    respond_to do |format|
      format.js
    end
  end

  private
    def car_params
      params.require(:car).permit(:make, :model, :year, :nickname, :description, :odometer )
    end

    def update_maintenance_items
      count = 0
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
      return count
    end
end
