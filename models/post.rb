require './models/application_model'

class Post < ApplicationModel
  TABLE = 'posts'

  def initialize(params)
    @columns = 'title, content, user_id, ip'
    @attributes = params
    @table_name = TABLE
  end

  class << self
    def table_name
      TABLE
    end

    def top(n)
      database.exec( "SELECT #{TABLE}.*, AVG(ratings.rate) as avg_rate FROM #{TABLE} LEFT JOIN ratings on #{TABLE}.id = ratings.post_id GROUP BY posts.id ORDER BY avg_rate ASC LIMIT #{n}").to_a
    end

    def ips
      all.group_by{|post| post['ip']}
    end

  end
end