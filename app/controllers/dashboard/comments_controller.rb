module Dashboard
  class CommentsController < Dashboard::BaseController
    before_action :set_comment, only: [:update, :destroy]

    def create
      @comment         = Comment.new(comment_params)
      @comment.user_id = current_user.id
      @comment.save
    end

    def update
      @comment.update_attributes(comment_params)
    end

    def destroy
      @comment.destroy
    end

    private

    def set_comment
      @comment = scoped_items.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:body, :story_id, :parent_id)
    end

    def scoped_items
      Comment.where(user_id: current_user.id)
    end
  end
end
