require 'rails_helper'
RSpec.describe 'Users', type: :request do
  describe 'Get/index: Successful Reponse' do
    before do
      FactoryBot.create_list(:user, 10)
      get "/v1/user"
    end
    it "return status code 200" do
        expect(response).to have_http_status(:success)
    end
    it "returns all users" do
      expect(json["data"].size).to eq(10)
    end
  end
  describe 'Post/Create: Create user successfully' do
    let!(:new_user) { FactoryBot.create(:user) }
    before do
      post '/v1/user', params:
                            {
                              user: {
                                Full_name: new_user.Full_name,
                                username: new_user.username,
                                password: new_user.password,
                                role: new_user.role
    }
                            }
    end
    it "return status 200" do
      expect(response).to have_http_status(:success)
    end
  end
  describe 'Post/create: Wrong parametrs' do
    let!(:new_user) {FactoryBot.create(:user)}
    it 'empty body parametrs' do
      post '/v1/user'
      expect(response).to have_http_status(:unprocessable_entity)
    end
    it 'missing body parametrs' do
      post '/v1/user', params:
                               {
                                 user: {
                                  Full_name: new_user.Full_name,
                                  username: new_user.username,
                                  password: new_user.password,
                                 }
                               }
      expect(response).to have_http_status(422)
    end
  end
end