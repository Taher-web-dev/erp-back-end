require 'rails_helper'
RSpec.describe 'Employees', type: :request do
    describe 'Get/index: Successful Response' do
        before do 
          FactoryBot.create_list(:employee, 10)
          get '/v1/employee'
        end
        it "return status code 200" do
            expect(response).to have_http_status(:success)
        end
        it "return all employees" do
            expect(json['data'].size).to eq(10)
        end
    end

    describe 'Post/ Create Employee' do
        let!(:new_employee) { FactoryBot.create(:employee)}
        it 'Create new employee successfuly' do
            post '/v1/employee', params:
                           {employee: {
                               name: new_employee.name,
                               family_name: new_employee.family_name,
                               birthday_date: new_employee.birthday_date,
                               hiring_date: new_employee.hiring_date,
                               photo_profile: new_employee.photo_profile,
                               net_salary: new_employee.net_salary,
        }
                           }
            expect(response).to have_http_status(200)
        end
        it 'Send create employee request without body parametr' do
            post '/v1/employee'
            expect(response).to have_http_status(400)
        end
        it 'Send create employee request with not valid data' do
            post '/v1/employee', params:
                {
                    employee: {
                        net_salary: 'string'
                    }
                }
            expect(response).to have_http_status(422)
        end
    end
    describe 'Update Employee' do
        before do 
            post '/v1/employee', params: 
                            {
                              employee:{
                                name: "test",
                                family_name: "test",
                                birthday_date: "1986-10-22",
                                hiring_date: "2018-09-10",
                                photo_profile: "string",
                                net_salary: 1220,
                            }
                          }
        end
        get '/v1/employee'
        let!(:employee) { json['data']}
        it 'Return Employee not found when using not available id' do
            patch '/v1/employee/808', params:
              {
                  employee: {
                    net_salary: 1440
                  }
              }
            expect(response).to have_http_status(404)
        end
        it 'Return bad request http status when Body parametrs not provided' do
            patch "/v1/employee/#{employee['id']}"
            expect(response).to have_http_status(400)
        end
        it "Return unauthorized http status when don't valid attributs to update." do
           patch "/v1/employee/#{employee['id']}", params:
              {
                  employee: {
                      age: 55
                  }
              }
            expect(response).to have_http_status(401)
        end
        it "update successfully when giving right employee id and right attributs with valid data" do
            patch "/v1/employee/#{employee['id']}", params:
            {
                employee: {
                    net_salary: 2500
                }
            }
          expect(response).to have_http_status(200)
        end
        it 'Return unprocessable entity http status when giving invalid data' do
            patch "/v1/employee/#{employee['id']}", params:
            {
                employee: {
                    net_salary: 'string'
                }
            }
          expect(response).to have_http_status(422)
        end

    end
    
    describe 'delete Employee' do
        before do 
            post '/v1/employee', params: 
                            {
                              employee:{
                                name: "test",
                                family_name: "test",
                                birthday_date: "1986-10-22",
                                hiring_date: "2018-09-10",
                                photo_profile: "string",
                                net_salary: 1220,
                            }
                          }
        end
        get '/v1/employee'
        let!(:employee) { json['data'] }
        it 'Return not found http status when deleting not found employee' do
          delete "/v1/employee/105"
          expect(response).to have_http_status(404)
        end
        it 'delete successfully employee giving his right id' do
          delete "/v1/employee/#{employee['id']}"
          expect(response).to have_http_status(200)
        end
    end
end