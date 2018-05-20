require 'rails_helper'

RSpec.describe 'Stories API', type: :request do
  # add stories owner
  let(:user) { create(:user) }
  before do
    allow_any_instance_of(Story).to receive(:category) { build_stubbed(:category) }
  end
  let!(:stories) { create_list(:story, 2, user_id: user.id) }
  let(:story_id) { stories.first.id }
  # authorize request
  let(:headers) { valid_headers }

  describe 'GET /api/v1/stories' do
    # update request with headers
    before { get '/api/v1/stories', params: {}, headers: headers }

    it 'returns stories' do
      expect(json).not_to be_empty
      expect(json.size).to eq(2)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /api/v1/stories/:id' do
    before { get "/api/v1/stories/#{story_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the story' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(story_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:story_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Story/)
      end
    end
  end

  describe 'POST /api/v1/stories' do
    let(:valid_attributes) do
      # send json payload
      FactoryBot.attributes_for(:story).merge(title: 'Learn Elm').to_json
    end

    context 'when request is valid' do
      before { post '/api/v1/stories', params: valid_attributes, headers: headers }

      it 'creates a story' do
        expect(json['title']).to eq('Learn Elm')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) { { title: nil }.to_json }
      before { post '/api/v1/stories', params: invalid_attributes, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(json['message'])
            .to match(/Validation failed: Description can't be blank/)
      end
    end
  end

  describe 'PUT /api/v1/stories/:id' do
    let(:valid_attributes) { { title: 'Shopping' }.to_json }

    context 'when the record exists' do
      before { put "/api/v1/stories/#{story_id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /api/v1/stories/:id' do
    before { delete "/api/v1/stories/#{story_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
