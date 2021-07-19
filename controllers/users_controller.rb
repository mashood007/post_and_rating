require './controllers/application_controller'
require './models/user'

class UsersController < ApplicationController
  def index
    @users = User.all
    [@users, "200 OK"]
  end

  def create
    @user = User.new(user_params)
    @user.save
    [@user, "200 OK"]
  end

  def login
    @user, @token = User.login(params['email'], params['password'])
    result = if @user.nil?
        {message: 'login failed'}.to_json
      else
        {message: 'login success', token: @token, user: @user}.to_json
      end
    [result, "200 OK"]
  end

  private

  def user_params
    "'#{params['email']}', '#{params['name']}', '#{params['password']}'"
  end
end