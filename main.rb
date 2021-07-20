require './config/router'
require './controllers/users_controller'
require './controllers/posts_controller'

def main
  puts 'server started...'
  Route.new.call
  puts 'server stoped'
end
main
