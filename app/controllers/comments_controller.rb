class CommentsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create


  	@recipe = Recipe.find(params[:recipe_id])
    @comment = @recipe.comments.build(comment_params)
    @comment.recipe = @recipe
    @comment.user = current_user

      # respond_to do |format|
    if @comment.save
       flash[:success] = "Comment created!"
       redirect_to @recipe
    else
      render @recipe
    end
  end

  def new
    @comment = @recipe.comments.build(comment_params)
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end

    # def correct_user
    #   @micropost = current_user.microposts.find_by(id: params[:id])
    #   redirect_to root_url if @micropost.nil?
    # end
  
end