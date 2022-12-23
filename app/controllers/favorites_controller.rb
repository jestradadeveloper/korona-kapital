
class FavoritesController < ApplicationController
  def create
    @favorite = Favorite.create( user: current_user, concert_id: params[:concert_id] )
    respond_to do |format|
      format.turbo_stream
    end
    #Favorite.create(user: current_user, concert_id: params[:concert_id])
    #redirect_to(:root)
    #render(partial: 'favorites/list')
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    @favorite.destroy
    #redirect_to(:root)
    #render(partial: 'favorites/list')
    respond_to do |format|
      format.turbo_stream
    end
  end
  def index
    if params[:count_only]
      render(partial: "favorites/count")
    end
  end

  private def favorite_params
    params.require(:concert_id)
  end
end
