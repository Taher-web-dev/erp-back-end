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
    end

    post('create user') do
      tags 'Users'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          username: { type: :string },
          password: { type: :string },
          role: { type: :string },
          employee_id: { type: :integer }
        },
        required: %w[username password role employee_id]
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
      response(400, 'body parametrs') do
        run_test!
      end
      response(422, 'validation') do
        run_test!
      end
    end
  end
  path '/v1/user/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, schema: {
      type: :string
    }
    patch('update user') do
      tags 'Users'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          username: { type: :string },
          password: { type: :string },
          role: { type: :string }
        }
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
      response(404, 'User not found') do
        run_test!
      end
      response(400, 'Body parametrs') do
        run_test!
      end
      response(401, 'Missing parametrs') do
        run_test!
      end
      response(422, 'Validation') do
        run_test!
      end
    end

    put('update user') do
      tags 'Users'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          username: { type: :string },
          password: { type: :string },
          role: { type: :string }
        }
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
      response(404, 'User not found') do
        run_test!
      end
      response(400, 'Body parametrs') do
        run_test!
      end
      response(401, 'Missing parametrs') do
        run_test!
      end
      response(422, 'Validation') do
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
      response(404, 'User not found') do
        run_test!
      end
      response(422, 'Validation') do
        run_test!
      end
    end
  end
end
