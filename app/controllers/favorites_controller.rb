class FavoritesController < ApplicationController

  before_filter :find_user

  def index

    @favorites = current_user.favorites
  end

  def create
    @recipe = Recipe.find params[:id]
    @user.favorites << @recipe
  def

  def destroy
    @user = current_user
    @favorite = @user.favorites.find_by_recipe_id params[:id]
    @favorite.destroy unless @favorite.blank?
  end
end
