class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy, :toggle_status]

  access [:all] => [:index, :show], [:author, :admin] => [:index, :show, :new, :create, :edit, :update, :destroy, :toggle_status]

  def index
    @blogs = Blog.all.order(created_at: :desc)
    @blogs = @blogs.search(params[:search]) unless params[:search].blank?
    @page_title = "Amazing Articles"
  end

  def show
      @page_title = @blog.title
      @seo_keywords = @blog.title
  end

  def new
    @blog = Blog.new
  end

  def edit
    if blog_belongs_to_user_or_admin
      render :edit
    else
      redirect_to @blog, notice: 'You are not allowed to do this, so sad'
    end
  end

  def create
    @blog = current_user.blogs.build(blog_params)
    respond_to do |format|
      if @blog.save
        format.html { redirect_to @blog, notice: 'Blog was successfully created.' }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if blog_belongs_to_user_or_admin
      respond_to do |format|
        if @blog.update(blog_params)
          format.html { redirect_to @blog, notice: 'Blog was successfully updated.' }
          format.json { render :show, status: :ok, location: @blog }
        else
          format.html { render :edit }
          format.json { render json: @blog.errors, status: :unprocessable_entity }
        end
      end
    else

    end
  end

  def destroy
    if blog_belongs_to_user_or_admin
      @blog.destroy
      respond_to do |format|
        format.html { redirect_to blogs_url, notice: 'Blog was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to blogs_path, notice: 'Permission Denied'
    end
  end

  def toggle_status
    if @blog.draft?
      @blog.published!
    elsif @blog.published?
      @blog.draft!
    end
    redirect_to blogs_url, notice: 'article status has been updated'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.friendly.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render 'not_found'
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_params
      params.require(:blog).permit(:title, :body, :status)
    end

    def blog_belongs_to_user_or_admin
      @blog.user.id == current_user.id || logged_in?(:admin)
    end
end
