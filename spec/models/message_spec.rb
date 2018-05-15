require 'rails_helper'

RSpec.describe Message, type: :model do
  context 'validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:body) }
    it { should validate_presence_of(:messageable_id) }
  end
end
