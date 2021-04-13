# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    resource, id = request.path.split('/')[1, 2]
    @commentable = resource.singularize.classify.constantize.find(id)
    @comment = @commentable.comments.build(comment_params)
    if @comment.save
      redirect_to @commentable, notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      redirect_to @commentable, notice: t('controllers.common.notice_fail', name: Comment.model_name.human)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(user_id: current_user.id)
  end
end
