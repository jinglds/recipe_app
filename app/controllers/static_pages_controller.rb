class StaticPagesController < ApplicationController

  def home
    # if signed_in?
    #   @micropost  = current_user.microposts.build
    #   @recipe  = current_user.recipes.build
    #   @feed_items = current_user.feed.paginate(page: params[:page])

     
     



    @recipes = Recipe.search(params[:all]).order("created_at DESC").paginate(page: params[:page], per_page: 4)
    @appetizers = Recipe.filtered_appetizers.order("created_at DESC").paginate(page: params[:a_page], per_page: 4)
    @mains = Recipe.filtered_mains.order("created_at DESC").paginate(page: params[:m_page], per_page: 4)
    @desserts = Recipe.filtered_desserts.order("created_at DESC").paginate(page: params[:d_page], per_page: 4)
    @beverages = Recipe.filtered_beverages.order("created_at DESC").paginate(page: params[:b_page], per_page: 4)

  end
  
  def help
  end

  def about
  end

  def contact
  end
  
end