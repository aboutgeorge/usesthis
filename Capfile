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
role :web, "usesthis.com"

namespace :deploy do
    task :start, :roles => :app do
        run "cd #{deploy_to}/current && nohup thin -s 3 -R config/rack.ru start"
    end
    
    task :stop, :roles => :app do
        run "cd #{deploy_to}/current && nohup thin -s 3 -R config/rack.ru stop"
    end
    
    task :restart, :roles => :app do
        deploy.stop
        deploy.start
    end
end