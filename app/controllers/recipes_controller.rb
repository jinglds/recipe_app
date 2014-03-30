class RecipesController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  

  def create
    @recipe = current_user.recipes.build(recipe_params)

    if @recipe.save
      flash[:success] = "Recipe created!"
      redirect_to @recipe
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
    @user = current_user
    @recipe = Recipe.find(params[:id])
    @comment = Comment.new 
    @comment_items =  @recipe.comment_feed.paginate(page: params[:page], per_page: 10)
  end



  def index

 
    @q = Recipe.search(params[:q])
    # @recipes = Recipe.search(params[:search]).order("created_at DESC").paginate(page: params[:page], per_page: 4)
    
    @recipes = @q.result(distinct: true).order("created_at DESC").paginate(page: params[:page], per_page: 8)
    
    if params[:tag]
    @recipes = @recipes.tagged_with(params[:tag]).order("created_at DESC").paginate(page: params[:page], per_page: 8)
    end
    @appetizers = Recipe.filtered_appetizers.order("created_at DESC").paginate(page: params[:a_page], per_page: 8)
    @mains = Recipe.filtered_mains.order("created_at DESC").paginate(page: params[:m_page], per_page: 8)
    @desserts = Recipe.filtered_desserts.order("created_at DESC").paginate(page: params[:d_page], per_page: 8)
    @beverages = Recipe.filtered_beverages.order("created_at DESC").paginate(page: params[:b_page], per_page: 8)

  end

  def feed_index
    if signed_in?
      # @micropost  = current_user.microposts.build
      @recipe  = current_user.recipes.build
      @feed_items = current_user.feed.paginate(page: params[:page], per_page:10)
      # @q = Recipe.search(params[:q])
      # @feed_items = @q.result(distinct: true).order("created_at DESC").paginate(page: params[:page], per_page: 10)
    
    end
 
    # @q = Recipe.search(params[:q])
    # # @recipes = Recipe.search(params[:search]).order("created_at DESC").paginate(page: params[:page], per_page: 4)
    
    # @recipes = @q.result(distinct: true).order("created_at DESC").paginate(page: params[:page], per_page: 4)
    
    # @appetizers = Recipe.filtered_appetizers.order("created_at DESC").paginate(page: params[:a_page], per_page: 4)
    # @mains = Recipe.filtered_mains.order("created_at DESC").paginate(page: params[:m_page], per_page: 4)
    # @desserts = Recipe.filtered_desserts.order("created_at DESC").paginate(page: params[:d_page], per_page: 4)
    # @beverages = Recipe.filtered_beverages.order("created_at DESC").paginate(page: params[:b_page], per_page: 4)

  end

  def search
    index
    render :index
  end



  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    @ingredients = @recipe.ingredients.all
    @directions = @recipe.directions.all


     if @recipe.update_attributes(recipe_params)
      redirect_to @recipe, notice: "Successfully updated recipe."
    else
      render :edit
    end
    
  end

  def feature
    @recipe = Recipe.find(params[:id])
    # if @recipe.toggle!(:featured)
    if @recipe.update_attributes(featured: true)
      redirect_to root_url, notice: "Successfully feature recipe" 
    else
     render redirect_to root_url
    end 
  end

  def unfeature
    @recipe = Recipe.find(params[:id])
    # if @recipe.toggle!(:featured)
    if @recipe.update_attributes(featured: false)
      redirect_to root_url, notice: "Successfully unfeature recipe" 
    else
     render redirect_to root_url
    end 
  end


  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_url, notice: "Successfully destroyed recipe."
  end



  def upvote
    @recipe = Recipe.find(params[:id])
    @recipe.liked_by current_user
    redirect_to @recipe
  end

  def downvote
    @recipe = Recipe.find(params[:id])
    @recipe.downvote_from current_user
    redirect_to @recipe
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
                                      :featured,
                                      :privacy,
                                      :image,
                                      :tag_list,
                                      ingredients_attributes: [:id, :item, :amount, :unit, :alternative, :_destroy],
                                      directions_attributes: [:id, :content, :_destroy]
                                      )
    end

    def correct_user
      @recipe = current_user.recipes.find_by(id: params[:id])
      redirect_to root_url if @recipe.nil?
    end

end