require 'rails_helper'

RSpec.describe Tag, type: :model do
  let(:subject) { build(:tag) }

  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:category) }
  context "Validation" do
    it { is_expected.to validate_presence_of(:name) }
  end
end
