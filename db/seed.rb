# frozen_string_literal: true

require './models/user'
require './models/post'
require 'faker'
require 'byebug'
require './models/rating'
class Seed
  def self.build
    100.times do
      user = User.new("'#{Faker::Internet.email}', '#{Faker::Name.first_name}', '#{Faker::Verb.past_participle}'")
      user = user.save
      user_id = user['id']
      50.times do
        ip_address = Faker::Internet.ip_v4_address
        40.times do
          posts_params = "'#{Faker::GreekPhilosophers.name}', '#{Faker::GreekPhilosophers.quote.gsub("'",
                                                                                                     "\\'")}', #{user_id}, '#{ip_address}'"
          post = Post.new(posts_params).save
          2.times do
            rate = Faker::Number.between(from: 1, to: 5)
            rate_params = "#{rate}, #{post['id']}"
            Rating.new(rate_params, params['rate']).save
          end
        end
      end
    end
  end
end

Seed.build
