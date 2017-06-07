class CommentsController < ApplicationController
  protect_from_forgery except: :edit
  before_action :set_comment, only: [:edit, :update, :destroy]
  def create
    @comment = current_user.comments.build(comment_params)
    @blog = @comment.blog
    respond_to do |format|
      if @comment.save
        format.html { redirect_to blog_path(@blog), notice: 'コメントを投稿しました。' }
        format.js { render :index }
      else
        format.html { render :new }
      end
    end
  end

  def destroy
    @comment.destroy
    redirect_to blog_path(@blog), notice: 'コメントを削除しました。'
  end

  def edit
    render 'edit_comment'
  end

  def update
    if @comment.update(comment_params)
    redirect_to blog_path(@blog), notice:"コメントを更新しました！"
    else
    redirect_to blog_path(@blog), notice:"失敗しました"
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
