class Ingredient < ActiveRecord::Base
	belongs_to :recipe
	validates :item, presence: true


	# def create


	# @recipe = Recipe.find(params[:recipe_id])
	# @ingredient = @recipe.ingredients.build(ingredient_params)
	# @ingredient.recipe = @recipe

	# end


 #  def new
 #    @ingredient = @recipe.ingredients.build(ingredient_params)
 #  end

 #  private

 #    def ingredient_params
 #      params.require(:item)
 #    end
  
end
