module AgentDashboard
  class StoriesController < AgentDashboard::BaseController
    before_action :set_story, only: [:show, :edit, :update, :destroy]

    def index
      @stories = scoped_items.order('created_at DESC')
    end

    def new
      @story = Story.new
    end

    def create
      @story         = Story.new(story_params)
      @story.user_id = current_user.id
      respond_to do |format|
        if @story.save
          format.html { redirect_to agent_dashboard_story_url(@story), notice: t('notifications.story_created_successfully') }
          format.json { render :show, status: :created, location: @story }
        else
          flash[:alert] = @story.errors.full_messages
          format.html { render :new }
          format.json { render json: @story.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @story.update(story_params)
          format.html { redirect_to agent_dashboard_story_url(@story), notice: t('notifications.story_updated_successfully') }
          format.json { render :show, status: :ok, location: @story }
        else
          flash[:alert] = @story.errors.full_messages
          format.html { render :edit }
          format.json { render json: @story.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @story.destroy
      respond_to do |format|
        format.html { redirect_to agent_dashboard_stories_url, notice: 'Brand was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
    def set_story
      @story= scoped_items.find(params[:id])
    end

    def story_params
      params.require(:story).permit(:name, :category_id, :description,
                                    :address, :latitude, :longitude, :phone, :web, :email,
                                    :logo, :cover_photo, tag_ids: [])
    end

    def scoped_items
      Story.where(user_id: current_user.id)
    end
  end
end
