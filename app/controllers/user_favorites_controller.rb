class UserFavoritesController < ApplicationController
  def create
    recipe_id = params[:recipe_id]
    user_id = current_user.id
    user_favorite = UserFavorite.create({recipe_id: recipe_id, user_id: user_id})
    render json: {user_favorite: user_favorite}
  end

  def destroy
  end
end
