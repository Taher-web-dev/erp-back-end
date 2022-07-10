# require_relative './responses_helper'
module Helpers::Errors
  USER_NOT_FOUND = Helpers::ResponsesHelper::Error.new('User', 101, 'User not found')
  EMPLOYEE_NOT_FOUND = Helpers::ResponsesHelper::Error.new('Employee', 102, 'Employee not found')
  BODY_PARAMETRS = Helpers::ResponsesHelper::Error.new('Body', 99, 'Body parametrs are missing or empty')
  MISSING_REQUIRED_PARAMETRS = Helpers::ResponsesHelper::Error.new('Missing Parametrs', 100, 'Missing required parametr')
  WRONG_CREDENTIALS = Helpers::ResponsesHelper::Error.new('Credentials', 150, 'Username or password not correct')
end
