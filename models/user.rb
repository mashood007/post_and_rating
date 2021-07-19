require './models/application_model'
require 'digest'

class User < ApplicationModel
  TABLE = 'users'
  attr_accessor :name, :email

  def initialize(params)
    @columns = 'email, name, password'
    @attributes = params
    @table_name = TABLE
  end

  class << self
    def table_name
      TABLE
    end

    def login(email, password)
      user = database.exec( "SELECT * FROM #{table_name} WHERE email = '#{email}' AND password = '#{password}'" ).to_a[0]
      unless user.nil?
        return [user, get_token(user['id'])]
      else
        [nil, nil]
      end
    end

    def get_token(id)
      Digest::SHA256.hexdigest("#{id}_#{Date.today}")
    end
  end
end

