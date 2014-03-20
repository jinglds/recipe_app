class RecipesController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @recipe = current_user.recipes.build(recipe_params)
    # @recipe.image = params[:file]
    if @recipe.save
      flash[:success] = "Recipe created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def new
    @recipe = current_user.recipes.build
  end

  def destroy
    @recipe.destroy
    redirect_to root_url
  end

  def show
    # @user = User.find(params[:id])
    # @microposts = @user.microposts.paginate(page: params[:page])
    @recipe = Recipe.find(params[:id])
    @comment = Comment.new 
    @comment_items =  @recipe.comment_feed.paginate(page: params[:page])
  end
  private

    def recipe_params
      params.require(:recipe).permit(:name,
                                      :description,
                                      :level,
                                      :course,
                                      :prep_time,
                                      :cook_time,
                                      :serving,
                                      :ingredients,
                                      :directions,
                                      :privacy,
                                      :image
                                      )
    end

    def correct_user
      @recipe = current_user.recipes.find_by(id: params[:id])
      redirect_to root_url if @recipe.nil?
    end
end