class CommentsController < ApplicationController

  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    @comment = @post.comments.build(params[:comment].permit(:body))
    @comment.user = current_user
    authorize @comment

    if @comment.save
      flash[:notice] = "Your comment has saved"
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the comment. Please try again"
      render :new
    end
  end

end
