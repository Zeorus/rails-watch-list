class ListsController < ApplicationController
  before_action :find_list, only: %i[show]

  def index
    @lists = List.all
  end

  def show
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_back(fallback_location: root_path, 
                    notice: "La liste \"#{@list.name}\" a été créée avec succès. Vous pouvez maintenant y ajouter des films.")
    else
      redirect_back(fallback_location: root_path, alert: "Erreur, votre liste n'a pas été sauvegardée.")
    end
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy
    redirect_to lists_path, notice: "La liste \"#{@list.name}\" a été supprimée avec succès."
  end

  private

  def list_params
    params.require(:list).permit(:name, :img)
  end

  def find_list
    @list = List.find(params[:id])
  end
end
