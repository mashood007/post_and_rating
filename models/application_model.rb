# frozen_string_literal: true

require 'pg'
class ApplicationModel
  attr_accessor :attributes, :table_name, :id, :columns

  class << self
    def database
      temp = PG.connect(dbname: 'template1')
      res = temp.exec('SELECT * from pg_database where datname = $1', ['user_rating'])
      temp.exec('CREATE DATABASE user_rating') if res.ntuples.zero?
      PG.connect(dbname: 'user_rating')
    end

    def all
      database.exec("SELECT * FROM #{table_name}").to_a
    end

    def find(id)
      where("id = #{id.to_i}")[0]
    end

    def update(values, condition = '1')
      database.exec("UPDATE #{table_name} SET #{values} WHERE #{condition}")
    end

    def where(query)
      database.exec("SELECT * FROM #{table_name} where #{query}").to_a
    end
  end

  def save
    @id = ApplicationModel.database.exec("INSERT INTO #{table_name}(#{columns}) VALUES(#{attributes}) RETURNING *")&.first
  end
end
