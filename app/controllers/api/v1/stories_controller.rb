module Api
  module V1
    class StoriesController < Api::BaseController
      before_action :set_story, only: [:show, :update, :destroy]

      # GET /stories
      def index
        # get current user stories
        @stories = current_user.stories.paginate(page: params[:page], per_page: 20)
        json_response(@stories)
      end

      # GET /stories/:id
      def show
        json_response(@story)
      end

      # POST /stories
      def create
        # create stories belonging to current user
        @story = current_user.stories.create!(story_params)
        json_response(@story, :created)
      end

      # PUT /stories/:id
      def update
        @story.update(story_params)
        head :no_content
      end

      # DELETE /stories/:id
      def destroy
        @story.destroy
        head :no_content
      end

      private

      def story_params
        params.permit(:title, :category_id, :description, :cover_photo, tag_ids: [])
      end

      def set_story
        @story = Story.find(params[:id])
      end
    end
  end
end
