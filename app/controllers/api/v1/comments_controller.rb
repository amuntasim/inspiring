module Api
  module V1
    class CommentsController < Api::BaseController
      before_action :set_story
      before_action :set_comment, only: [:show, :update, :destroy]

      def index
        @comments = fetch_comments
        render json: @comments, meta: pagination_dict(@comments)
      end

      def show
        json_response(@story)
      end

      def create
        @comment = @story.comments.create!(comment_params.merge(user_id: @current_user&.id))
        json_response(@comment, :created)
      end

      def update
        @comment.update(comment_params)
        json_response(@comment)
      end

      def destroy
        @comment.destroy
        head :no_content
      end
      private

      def fetch_comments
        @comments = @story.comments
        @comments = @comments.roots if params[:root_comments].present?
        if params[:parent_id].present?
          @comments = @comments.where(parent_id: params[:parent_id]).order("created_at ASC")
        end
        @comments = @comments.paginate(:page => params[:page], per_page: params[:skip_paginate] ? @comments.count : 10 )
      end

      def comment_params
        params.require(:comment).permit(:body, :parent_id)
      end

      def set_comment
        @comment = @story.comments.find(params[:id])
      end

      def set_story
        @story = Story.find(params[:story_id])
      end
    end
  end
end
