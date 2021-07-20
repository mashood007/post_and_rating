task :run do
  ruby "main.rb"
end

namespace :db do
  task :migrate do
    ruby "db/migrations.rb"
  end

  task :seed do
    ruby "db/seed.rb"
  end

end