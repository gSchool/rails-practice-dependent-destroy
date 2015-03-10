class MedicationsController < ApplicationController
  def new
    @medication = Medication.new
  end

  def create
    @medication = Medication.new(params.require(:medication).permit(:name))
    if @medication.save
      flash[:notice] = "YAY the lobbyists have won!"
      redirect_to root_path
    else
      render :new
    end
  end


  def show
    @medication = Medication.find(params[:id])
  end

  def destroy
    medication = Medication.find(params[:id])
    medication.destroy
    flash[:notice] = "Say goodbye to that paycheck :("
    redirect_to root_path
  end



end
