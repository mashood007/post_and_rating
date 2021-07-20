# frozen_string_literal: true

class ApplicationController
  attr_accessor :action_name

  def initialize(parameters, arguments, action)
    @params = parameters
    @args = arguments
    @action_name = action
  end

  attr_reader :params, :args

  def authenticate_user?
    !current_user.nil? && User.get_token(params['user_id']) == params['token']
  end

  def current_user
    User.find(params['user_id'])
  end
end
