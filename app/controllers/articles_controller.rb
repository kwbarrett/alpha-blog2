class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def new
    @article = Article.new
  end

  def edit
    # render plain: @article.inspect
  end

  def create
    # debugger
    # render plain: params[:article].inspect
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:success] = 'Article created!!'
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def update
    # render plain: params[:article].inspect
    if @article.update(article_params)
      flash[:success] = 'Article updated!!'
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def show
    # render plain: @article.inspect
  end

  def destroy
    @article.destroy
    flash[:danger] = 'Article deleted!!'
    redirect_to articles_path
  end

  private
  def article_params
    params.require(:article).permit(:title, :description)
    # render plain: params[:article].inspect
  end

  def set_article
    @article = Article.find(params[:id])
  end

  def require_same_user
    if current_user != @article.user
      flash[:danger] = "Only the author can edit/delete his/her articles"
      redirect_to root_path
    end
  end

end
