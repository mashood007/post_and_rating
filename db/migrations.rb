require 'pg'

def migrate
  temp = PG.connect( dbname: 'template1' )
  res1 = temp.exec('SELECT * from pg_database where datname = $1', ['user_rating'])
  if res1.ntuples == 0
    temp.exec('CREATE DATABASE user_rating')
  end
  db = PG.connect(dbname: 'user_rating')

  create_table(db, 'users', 'id SERIAL PRIMARY KEY, email VARCHAR ( 50 ) UNIQUE NOT NULL, name VARCHAR (50) NOT NULL, password VARCHAR (50) NOT NULL')
  create_table(db, 'posts', 'id SERIAL PRIMARY KEY, title VARCHAR ( 50 ) NOT NULL, content VARCHAR (1000), user_id INTEGER NOT NULL, ip VARCHAR (50)')
  create_table(db, 'ratings', "id SERIAL PRIMARY KEY, rate INTEGER NOT NULL, post_id INTEGER NOT NULL , #{references('posts', 'post_id')}")
  # alter_table(db, 'ratings', 'ADD COLUMN rate INTEGER NOT NULL')
end

def create_table(db, table_name, schema)
  db.exec("CREATE TABLE IF NOT EXISTS #{table_name}(#{schema})")
end

def alter_table(db, table_name, query)
  db.exec("ALTER TABLE #{table_name} #{query}")
end

def references(foreign_table, column, id = 'id')
  "CONSTRAINT #{foreign_table}_#{column} FOREIGN KEY(#{column}) REFERENCES #{foreign_table}(#{id})"
end
migrate