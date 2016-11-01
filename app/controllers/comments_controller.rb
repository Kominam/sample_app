class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @micropost = Micropost.find_by id: params[:micropost_id]
    @comment = @micropost.comments.create comment_params
    @comment.user = current_user
    if @comment.save!
      respond_to do |format|
        format.html{redirect_to @micropost}
        format.js
      end
    end
  end

  def destroy
  end

  private

  def comment_params
    params.require(:comment).permit :content
  end
end
