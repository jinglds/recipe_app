class Direction < ActiveRecord::Base
	belongs_to :recipe


	# def create


	# @recipe = Recipe.find(params[:recipe_id])
	# @direction = @recipe.directions.build(direction_params)
	# @direction.recipe = @recipe

	# end


 #  def new
 #    @direction = @recipe.directions.build(direction_params)
 #  end

 #  private

 #    def direction_params
 #      params.require(:item)
 #    end
  
end
