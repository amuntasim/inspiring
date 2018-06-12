require 'rails_helper'

RSpec.describe Review, type: :model do
  context 'validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:rating) }
  end

  context 'create' do
    it 'should update brand ratings' do
      allow_any_instance_of(Brand).to receive(:category) {build_stubbed(:category)}
      brand = create(:brand)

      review = create(:review, rating: 4, reviewable: brand)
      expect(brand.reload.reviews_count).to eq 1
      expect(brand.avg_rating).to eq 4
    end
  end
end
