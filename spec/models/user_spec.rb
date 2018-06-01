describe User do

  it { should respond_to(:email) }

  context "create" do
    it 'sets handle' do
      user = create(:user)
      expect(user.handle).to eq user.email.split("@").first
    end
  end

end
