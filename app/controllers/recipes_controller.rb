class RecipesController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  

  def create
    @recipe = current_user.recipes.build(recipe_params)

    if @recipe.save
      flash[:success] = "Recipe created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def new
    # @recipe = current_user.recipes.build
    @recipe = Recipe.new
    @recipe.ingredients.build
    @recipe.directions.build
  end

  def destroy
    @recipe.destroy
    redirect_to root_url
  end

  def show
    # @recipes.directions
    # @user = User.find(params[:id])
    # @microposts = @user.microposts.paginate(page: params[:page])

    @recipe = Recipe.find(params[:id])
    @comment = Comment.new 
    @comment_items =  @recipe.comment_feed.paginate(page: params[:page], per_page: 10)
  end


  def index
    if params[:search]
      @recipes = Recipe.search(params[:search]).order("created_at DESC").paginate(page: params[:page], per_page: 4)
    else
      @recipes = Recipe.search(params[:all]).order("created_at DESC").paginate(page: params[:page], per_page: 4)
    end
    # # @appetizers = Recipe.appetizers
    # # @appetizers = Recipe.filtered_by_course(params[:appetizers])
    @appetizers = Recipe.filtered_appetizers.order("created_at DESC").paginate(page: params[:a_page], per_page: 4)
    @mains = Recipe.filtered_mains.order("created_at DESC").paginate(page: params[:m_page], per_page: 4)
    @desserts = Recipe.filtered_desserts.order("created_at DESC").paginate(page: params[:d_page], per_page: 4)
    @beverages = Recipe.filtered_beverages.order("created_at DESC").paginate(page: params[:b_page], per_page: 4)

  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    @ingredients = @recipe.ingredients.all
    @directions = @recipe.directions.all
    
    if @recipe.update_attributes(recipe_params) && @recipe.update_attributes(recipe_params)
      redirect_to @recipe, notice: "Successfully updated recipe."
    else
      render :edit
    end
  end








  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_url, notice: "Successfully destroyed recipe."
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
                                      :image,
                                      ingredients_attributes: [:id, :item, :amount, :unit, :alternative],
                                      directions_attributes: [:id, :content]
                                      )
    end

    def correct_user
      @recipe = current_user.recipes.find_by(id: params[:id])
      redirect_to root_url if @recipe.nil?
    end

end