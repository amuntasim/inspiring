require 'rails_helper'

RSpec.describe Brand, type: :model do
  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:user_id) }
  end

end
