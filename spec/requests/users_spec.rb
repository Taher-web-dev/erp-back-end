require 'rails_helper'
RSpec.describe 'Users', type: :request do
  before do 
    post '/v1/employee', params: 
                    {
                      employee:{
                        "name": "test",
                        "family_name": "test",
                        "birthday_date": "2022-06-30",
                        "hiring_date": "2022-06-30",
                        "photo_profile": "string",
                        "net_salary": 1550
                    }
                  }
                  
  end
  get '/v1/employee'
  let!(:employee_id) { json['data']['id'] }
  describe 'Get/index: Successful Reponse' do
    before do
      post '/v1/user', params:
              { user:{
                username: Faker::Lorem.word,
                password: Faker::Lorem.word,
                role: 'admin',
                employee_id: employee_id,
    }
              }
          
      #FactoryBot.create_list(:user, 10)
      get '/v1/user'
    end
    it 'return status code 200' do
      expect(response).to have_http_status(:success)
    end
    it 'returns all users' do
      expect(json['data'].size).to eq(1)
    end
  end
  describe 'Post/Create: Create user successfully' do
    #let!(:new_user) { FactoryBot.create(:user) }
    before do
      get '/v1/user'
      current_user = json['data'].select do |us|
        us['username'] == 'test' && us['password'] == 'test'
      end
      delete "/v1/user/#{current_user[0]['id']}" unless current_user.empty?
      post '/v1/user', params:
                            { 
                              user: {
                                username: 'test',
                                password: 'test',
                                role: 'admin',
                                employee_id: employee_id
    }
                            }
    end
    it 'return status 200' do
      expect(response).to have_http_status(:success)
    end
    it 'Raise exception for duplicated users' do
      post '/v1/user', params:
      {
        user: {
          username: 'test',
          password: 'test',
          role: 'admin',
          employee_id: employee_id
        }
      }
      expect(response).to have_http_status(422)
    end
  end
  describe 'Post/create: Create user with Wrong parametrs' do
    #let!(:new_user) { FactoryBot.create(:user) }
    it 'empty body parametrs' do
      post '/v1/user'
      expect(response).to have_http_status(:bad_request)
    end
    it 'missing body parametrs' do
      post '/v1/user', params:
                               {
                                 user: {
                                   username: 'example',
                                   password: 'example',
                                 }
                               }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
  describe 'Patch/update' do
    before do 
      post '/v1/user', params: 
                      {
                        user:{
                          "username": "test",
                          "password": "test",
                          "role": "admin",
                          "employee_id": employee_id,
                      }
                    }
    end
    get '/v1/user'
    let!(:new_user) { json['data'] }
    it 'update successfully with correct parametrs' do
      patch "/v1/user/#{new_user['id']}", params: {
        
          username: 'Aziz',
          password: 'test'
        
      }
      #p json['error']['message']
      expect(response).to have_http_status(200)
    end
    it 'update with not found user id' do
      patch '/v1/user/1025', params:
                               {
                                   username: 'Lilly',
                                   password: 'test'
                               }
      expect(response).to have_http_status(404)
    end
    it 'update with wrong parametr' do
      get '/v1/user'
      patch "/v1/user/#{new_user['id']}", params:
                           {
                               phone: 77_471_580,
                           }
      expect(response).to have_http_status(401)
    end
    
  end
  describe 'Delete/Destroy' do
    it 'delete not existed user' do
      delete '/v1/user/1189'
      expect(response).to have_http_status(404)
    end
    it 'delete successfully exist user' do
      delete '/v1/user/1'
    end
  end
end
