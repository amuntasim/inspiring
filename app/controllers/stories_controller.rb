class StoriesController < ApplicationController
  def show
    @story = Story.find(params[:id])
    respond_to do |format|
      format. html {
        @serialized_story = StorySerializer.new(@story, scope: view_context)
        @serialized_story = ActiveModel::Serializer::Adapter.create(@serialized_story)
      }
      format.js
    end
  end
end
