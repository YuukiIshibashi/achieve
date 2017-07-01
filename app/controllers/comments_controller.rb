class CommentsController < ApplicationController
  protect_from_forgery except: :edit
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def show
  end

  def create
    @comment = current_user.comments.build(comment_params)
    @blog = @comment.blog
    @notification = @comment.notifications.build(user_id: @blog.user.id )
    respond_to do |format|
      if @comment.save
        format.html { redirect_to blog_path(@blog) }
        format.js { render :index }
        unless @comment.blog.user_id == current_user.id
        Pusher.trigger("user_#{@comment.blog.user_id}_channel", 'comment_created', {
          message: 'あなたの作成したブログにコメントが付きました'
        })
        Pusher.trigger("user_#{@comment.blog.user_id}_channel", 'notification_created', {
          unread_counts: Notification.where(user_id: @comment.blog.user.id, read: false).count
        })
        end
      else
        format.html { render :new }
      end
    end
  end

  def destroy
    respond_to do |format|
      @comment.destroy
      format.html { redirect_to blog_path(@blog), notice: 'コメントを削除しました。' }
      format.js { render :delete }
    end
  end

  def edit
  end

  def update
      respond_to do |format|
        if @comment.update(comment_params)
          format.html { redirect_to blog_path(@blog), notice: 'コメントを訂正しました。' }
          format.js { render :edit_index }
        else
          format.html { redirect_to blog_path(@blog), notice: 'エラーが発生しました。' }
        end
      end
  end

  private
    def comment_params
      params.require(:comment).permit(:blog_id, :content)
    end

    def set_comment
      @comment = Comment.find(params[:id])
      @blog = @comment.blog
    end
end
