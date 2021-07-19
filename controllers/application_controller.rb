require 'json'
class ApplicationController
  attr_accessor :action_name
  def initialize(parameters, arguments, action)
    @params = parameters
    @args = @args
    @action_name = action 
  end

  def params
    @params
  end

  def args
    @args
  end

  def authenticate_user?
    p params,"----"
    !current_user.nil? && User.get_token(params['user_id']) == params['token']
  end

  def current_user
    User.find(params['user_id'])
  end
end