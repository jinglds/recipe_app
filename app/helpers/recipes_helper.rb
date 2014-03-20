module RecipesHelper

  def recipe_image(recipe)
    image_tag('/assets/images/' + recipe.image_path.downcase + '.jpg')
  end
end