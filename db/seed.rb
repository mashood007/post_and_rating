require './models/user'

class Seed
  def self.build
    @user = User.new("'test@test.com', 'Test User', '123456'")
    @user.save
  end
end

Seed.build