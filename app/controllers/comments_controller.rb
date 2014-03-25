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

  def destroy
    @recipe= Recipe.find(params[:recipe_id])
    @comment = @recipe.comments.find(params[:id])
    @comment.destroy

# <%= link_to "delete", recipe_comment_path, method: :delete,
#                                      data: { confirm: "You sure?" },
#                                      title: comment_item.content %>
    flash[:success] = "Comment created!"
       redirect_to @recipe
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