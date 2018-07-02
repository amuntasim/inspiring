module Api
  module V1
    class StoriesController < Api::BaseController
      before_action :set_story, only: [:show, :update, :destroy, :inspired]
      skip_before_action :authorize_request!, only: [:index]

      # GET /stories
      def index
        @stories = StorySearchFacade.new(params).stories
        render json: @stories, meta: pagination_dict(@stories).merge(current_user_meta || {})
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

      def inspired
        inpiration = Inspiration.create_or_destroy!(@story, current_user.id)
        if inpiration.destroyed?
          render json: { inpiration_id: inpiration.id, deleted: 1 }, status: 202
        else
          json_response(inpiration, :created)
        end
      end

      private
      def story_params
        params.permit(:title, :category_id, :description, :cover_photo, tag_ids: [])
      end

      def set_story
        @story = Story.find(params[:id])
      end

      def current_user_meta
        if current_user && params[:current_user_meta]
          inspired_story_ids = Inspiration.stories.
              where(inspiring_id: @stories.pluck(:id), user_id: current_user.id).pluck(:inspiring_id)
          {inspired_story_ids: inspired_story_ids}
        end
      end
    end
  end
end
