namespace :dev do
  desc "Rebuild the system"
  task :build => ["tmp:clear", "log:clear", "db:reset", "db:setup"]
  task :rebuild => ["tmp:clear", "log:clear", "db:drop", "db:create","db:migrate","dev:populate"]

  desc "populate data to db"
  task :populate => :environment do
    # require 'faker'
    # require 'ffaker'

  end
end

# http://stackoverflow.com/questions/5108876/kill-a-postgresql-session-connection
namespace :db do
  desc "Fix 'database is being accessed by other users'"
  task :terminate => :environment do
    ActiveRecord::Base.connection.execute <<-SQL
      SELECT
        pg_terminate_backend(pid)
      FROM
        pg_stat_activity
      WHERE
        -- don't kill my own connection!
        pid <> pg_backend_pid()
        -- don't kill the connections to other databases
        AND datname = '#{ActiveRecord::Base.connection.current_database}';
    SQL
  end
end

Rake::Task["db:drop"].enhance ["db:terminate"]
