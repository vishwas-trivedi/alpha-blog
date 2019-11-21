class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  
  # Listing with index action
  def index
    @articles = Article.all
  end

  # New action
  def new
    @article = Article.new
  end

  # Create action
  def create
    #render plain: params[:article].inspect
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = "Article was successfully created."
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
      flash[:notice] = "Article was usccessfully updated."
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    flash[:notice] = "Article was successfully deleted."
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
end
