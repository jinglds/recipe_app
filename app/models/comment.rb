class Comment < ActiveRecord::Base

  belongs_to :user
  belongs_to :recipe

  validates :content, presence: true
  validates :user_id, presence: true
  validates :recipe_id, presence: true  


  # Returns recipes from the users being followed by the given user.
  def self.in_recipe(recipe)
    comment_id = "SELECT id FROM comments
                          WHERE recipe_id = :recipe_id"
    where("id = :recipe_id",
          recipe_id: recipe.id)
  end
end
