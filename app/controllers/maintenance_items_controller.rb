class MaintenanceItemsController < ApplicationController
  def show
    @maintenanceItem = MaintenanceItem.find(params[:id])
  end

  def new
    @car = Car.find(params[:car_id])
    @maintenanceItem = MaintenanceItem.new
  end

  def create
    @car = Car.find(params[:car_id])
    @maintenanceItem = @car.maintenance_items.build(maintenance_items_params)
    if(@maintenanceItem.save)
      redirect_to car_path(@maintenanceItem.car)
    else
      render 'new'
    end
  end

  def edit
    @car = Car.find(params[:car_id])
    @maintenanceItem = MaintenanceItem.find(params[:id])
  end

  def update
    @maintenanceItem = MaintenanceItem.find(params[:id])
    if @maintenanceItem.update_attributes(maintenance_items_params)
      flash[:success] = "Maintenance item updated"
      redirect_to car_path(@maintenanceItem.car)
    else
      render 'edit'
    end
  end

  def destroy
    MaintenanceItem.find(params[:id]).destroy
    flash[:success] = "Maintenance item deleted"
    redirect_to car_path(:id => params[:car_id])
  end

  def item_checked_up_on
    @maintenanceItem = MaintenanceItem.find(params[:id])
    if(@maintenanceItem && @maintenanceItem.car.user_id == current_user.id)
      @maintenanceItem.update_attributes(:last_maintained_odometer => @maintenanceItem.car.odometer, :due_for_checkup => false)
      respond_to do |format|
        format.js
      end
    end
  end

  private
    def maintenance_items_params
      params.require(:maintenance_item).permit(:name, :description, :interval, :last_maintained_odometer, :due_for_checkup)
    end
end
