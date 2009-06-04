load 'deploy' if respond_to?(:namespace) # cap2 differentiator

set :application,       "usesthis"
set :branch,            "master"
set :deploy_to,         "/usr/local/www/apps/#{application}"
set :deploy_via,        :remote_cache
set :repository,        "git@github.com:waferbaby/usesthis.git"
set :runner,            "daniel"
set :scm,               :git
set :user,              "daniel"
set :use_sudo,          false

role :app, "usesthis.com"
role :db,  "usesthis.com", :primary => true
role :web, "usesthis.com"

namespace :deploy do  
        desc "Link up the application config file."
        task :after_update_code do
          run "ln -nfs #{shared_path}/usesthis.yml #{release_path}/usesthis.yml" 
        end
        
        desc "Restart usesthis."
        task :restart, :roles => :app do
          run "touch /usr/local/www/apps/usesthis/current/restart.txt"
        end
end