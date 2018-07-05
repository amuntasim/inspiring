require 'rails_helper'

RSpec.describe Inspiration, type: :model do
  context 'validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:inspiring_id) }
  end

  context "caching" do
    it 'should update cache' do
      allow_any_instance_of(Inspiration).to receive(:user) { User.new }
      allow_any_instance_of(Brand).to receive(:category) { Category.new }
      Rails.cache.delete_matched("cached_properties*")
      Rails.cache.delete_matched("cached_spaces*")
      inspiration = create(:inspiration,:brand )
      expect(Inspiration.inspired_ids(inspiration.inspiring_type, inspiration.user_id)).to eq [inspiration.inspiring_id]

      inspiration.destroy
      expect(Inspiration.inspired_ids(inspiration.inspiring_type, inspiration.user_id)).to eq []
    end
  end

  context '.create_or_destroy!' do
    before do
      @user = create(:user)
      allow_any_instance_of(Inspiration).to receive(:user) { User.new }
      allow_any_instance_of(Brand).to receive(:category) { Category.new }
      @brand = create(:brand, user: @user)
    end

    it 'should create  inspiration' do
      inspiration = Inspiration.create_or_destroy!(@brand, @user.id)
      expect(inspiration.id > 0).to be_truthy
      expect(@user.reload.inspiration_points).to eq 1
    end

    it 'should destroy inspiration' do
      Inspiration.create_or_destroy!(@brand, @user.id)
      inspiration = Inspiration.create_or_destroy!(@brand, @user.id)
      expect(inspiration.destroyed?).to be_truthy
      expect(@user.reload.inspiration_points).to eq 0
    end
  end
end
