describe User do

  it { should respond_to(:email) }
  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:handle) }
  end

  context "create" do
    it 'sets handle' do
      user = create(:user)
      expect(user.handle).to eq user.email.split("@").first
    end
  end

end
