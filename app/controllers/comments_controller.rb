class CommentsController < ApplicationController
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(params_comment)
    @comment.user = current_user
    @comment.save
    redirect_to article_path(@article)
  end

  private
    def params_comment
      params.require(:comment).permit(:body)
    end
end