class CommentsController < ApplicationController
  protect_from_forgery except: :edit
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def show
  end

  def create
    @comment = current_user.comments.build(comment_params)
    @blog = @comment.blog
    respond_to do |format|
      if @comment.save
        format.html { redirect_to blog_path(@blog) }
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
  end

  def update
    @comment.update(comment_params)
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
