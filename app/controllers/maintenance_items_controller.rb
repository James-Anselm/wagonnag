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
      redirect_to car_maintenance_item_path(@maintenanceItem.car, @maintenanceItem)
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
      redirect_to car_maintenance_item_path(@maintenanceItem.car, @maintenanceItem)
    else
      render 'edit'
    end
  end

  def destroy
    MaintenanceItem.find(params[:id]).destroy
    flash[:success] = "Maintenance item deleted"
    redirect_to car_path(:id => params[:car_id])
  end

  private
    def maintenance_items_params
      params.require(:maintenance_item).permit(:name, :description, :interval)
    end
end
