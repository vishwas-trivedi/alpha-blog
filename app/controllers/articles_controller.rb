class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  # Listing with index action
  def index
    @articles = Article.paginate(page: params[:page], per_page: 8)
  end

  # New action
  def new
    @article = Article.new
    @article.comment = Comment.new
  end

  # Create action
  def create
    # render plain: params[:article].inspect
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:success] = "Article was successfully created."
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  # Show action
  def show
  end

  def edit
  end

  def update
    if @article.update(article_params)
      flash[:success] = "Article was usccessfully updated."
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    flash[:success] = "Article was successfully deleted."
    redirect_to articles_path;
  end

  private
    # Common method to find article with ID
    def set_article
      @article = Article.find(params[:id])
    end

    # Whitelisting or strong parameters
    def article_params
      params.require(:article).permit(:title, :description)
    end

    def require_same_user
      if current_user != @article.user
        flash[:danger] = 'You can only edit or delete your own article.'
        redirect_to root_path
      end
    end
end
