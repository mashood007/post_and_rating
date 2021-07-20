require './controllers/application_controller'
require './models/post'
require './models/rating'
class PostsController < ApplicationController
  def create
    if authenticate_user?
      @post = Post.new(posts_params)
      @post.save
      [@post, '200 OK']
    else
      ['Authentication failed', '401 ERROR']
    end
  end

  def index
    if authenticate_user?
      @posts = Post.where("user_id = #{params['user_id']}")
      [@posts, '200 OK']
    else
      ['Authentication failed', '401 ERROR']
    end
  end

  def topn
    @posts = Post.top(params['n'].to_i)
    [@posts, '200 OK']
  end

  def rate
    Rating.new(rate_params, params['rate']).save
  end

  def ips
    [Post.ips, '200 OK']
  end

  private

  def posts_params
    post = params['post']
    "'#{post['title']}', '#{post['content']}', #{params['user_id']}, '#{params['ip_address']}'"
  end

  def rate_params
    "#{params['rate']}, #{params['id']}"
  end
end
