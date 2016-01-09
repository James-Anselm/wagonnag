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
      redirect_to car_path(@car)
    else
      render 'new'
    end
  end

  def destroy
    MaintenanceItem.find(params[:id]).destroy
    flash[:success] = "Maintenance item deleted"
    redirect_to car_path(:id => current_user.id)
  end

  private
    def maintenance_items_params
      params.require(:maintenance_item).permit(:name, :description, :interval)
    end
end
