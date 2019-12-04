class CommentsController < ApplicationController
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(params_comment)
    @comment.user = current_user
    if @comment.save
      flash[:success] = "Comment successsfully added"
    else
      flash[:danger] = "Failed to add comment. It shoule be between 10-120 characters."
    end

    redirect_to article_path(@article)
  end

  private
    def params_comment
      params.require(:comment).permit(:body)
    end
end