require 'swagger_helper'

RSpec.describe 'v1/employee', type: :request do

  path '/v1/employee' do

    get('list employees') do
      tags 'Employees'
      response(200, 'successful') do

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    post('create employee') do
      tags 'Employees'
      consumes 'application/json'
      parameter name: :employee, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          family_name: { type: :string },
          birthday_date: { type: :string , format: :date},
          hiring_date: { type: :string, format: :date},
          photo_profile: { type: :string },
          net_salary: { type: :number, format: :float},
        },
        required: %w[name family_name ],
      }
      response(200, 'successful') do

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(400, 'Body parametrs') do
        run_test!
      end
      response(422, 'Validation data') do
        run_test!
      end
    end
  end

  path '/v1/employee/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'
    patch('update employee') do
      tags 'Employees'
      consumes 'application/json'
      parameter name: :employee, in: :body, schema: {
      type: :object,
      properties: {
        name: { type: :string },
        family_name: { type: :string },
        birthday_date: { type: :string , format: :date},
        hiring_date: { type: :string, format: :date},
        photo_profile: { type: :string },
        net_salary: { type: :number, format: :float},
      },
    }
      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
      response(404, 'Employee not found') do
        run_test!
      end
      response(400, 'Body parametrs') do
        run_test!
      end
      response(403, 'Missing Required Parametrs') do
        run_test!
      end
      response(422, 'Validation data') do
        run_test!
      end
    end

    put('update employee') do
      tags 'Employees'
      consumes 'application/json'
      parameter name: :employee, in: :body, schema: {
      type: :object,
      properties: {
        name: { type: :string },
        family_name: { type: :string },
        birthday_date: { type: :string , format: :date},
        hiring_date: { type: :string, format: :date},
        photo_profile: { type: :string },
        net_salary: { type: :number, format: :float},
      },
    }
      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
      response(404, 'Employee not found') do
        run_test!
      end
      response(400, 'Body parametrs') do
        run_test!
      end
      response(403, 'Missing Required Parametrs') do
        run_test!
      end
      response(422, 'Validation data') do
        run_test!
      end
    end

    delete('delete employee') do
      tags 'Employees'
      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
      response(404, 'Employee not found') do
        run_test!
      end
      response(422, 'Validation data') do
        run_test!
      end
    end
  end
end
