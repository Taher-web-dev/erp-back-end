require 'swagger_helper'

RSpec.describe 'v1/user', type: :request do
  path '/v1/user' do
    get('list users') do
      tags 'Users'
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
      response(422, 'users not found') do
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

    post('create user') do
      tags 'Users'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          Full_name: { type: :string },
          username: { type: :string },
          password: { type: :string },
          role: { type: :string }
        },
        required: %w[Full_name username password role]
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
      response(422, 'body parametrs') do
        run_test!
      end
      response(403, 'database validation and processing') do
        run_test!
      end
    end
  end
  path '/v1/user/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, schema: {
      type: :string
    }
    parameter name: :user, in: :body, schema: {
      type: :object,
      properties: {
        Full_name: { type: :string },
        username: { type: :string },
        password: { type: :string },
        role: { type: :string }
      }
    }
    patch('update user') do
      tags 'Users'
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
      response(404, 'user not found') do
        run_test!
      end
      response(422, 'database validation and processing') do
        run_test!
      end
    end

    put('update user') do
      tags 'Users'
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
      response(404, 'user not found') do
        run_test!
      end
      response(422, 'database validation and processing') do
        run_test!
      end
    end
  end
  path '/v1/user/{id}' do
    delete('delete user') do
      tags 'Users'
      parameter name: 'id', in: :path, type: :string, description: 'id'
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
    end
  end
end
