class BlogsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_blog, only: [:edit, :update, :destroy, :show]

  def index
    @blogs = Blog.all
  end

  def new
    if params[:back]
      @blog = Blog.new(blogs_params)
    else
      @blog = Blog.new
    end
  end

  def confirm
    @blog = Blog.new(blogs_params)
    render :new if @blog.invalid?
  end

  def create
    @blog = Blog.new(blogs_params)
    @blog.user_id = current_user.id
    if params[:back]
      render  :new
    else
      @blog.save
      if @blog.save
       redirect_to blogs_path, notice:"ブログを作成しました！"
       NoticeMailer.sendmail_blog(@blog).deliver
      else
       render action:'new'
      end
    end
  end

  def show
    @comment = @blog.comments.build
    @comments = @blog.comments
    @comments = @comments.order(:created_at)
    Notification.find(params[:notification_id]).update(read: true) if params[:notification_id]
  end

  def edit
    unless current_user ==  @blog.user
      redirect_to blogs_path
    end
  end

  def update
    # @blog = Blog.find(params[:id])
    if @blog.update(blogs_params)
    redirect_to blogs_path, notice:"ブログを更新しました！"
    else
      render action: 'edit'
    end
  end

  def destroy
    # @blog = Blog.find(params[:id])
    @blog.destroy
    redirect_to blogs_path, notice: "ブログを削除しました！"
  end

  private
   def blogs_params
     params.require(:blog).permit(:title, :content)
   end

   def set_blog
     @blog = Blog.find(params[:id])
   end

end
