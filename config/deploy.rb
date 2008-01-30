set :application, "foosball"
set :repository,  "/repo/foosball.git"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/var/www/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, :git

role :app, "core.trondheim.corp.yahoo.com"
role :web, "core.trondheim.corp.yahoo.com"
role :db,  "core.trondheim.corp.yahoo.com", :primary => true
