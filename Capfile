load 'deploy' if respond_to?(:namespace) # cap2 differentiator

set :application,       "usesthis.com"
set :branch,            "master"
set :deploy_to,         "/usr/local/www/#{application}"
set :deploy_via,        :remote_cache
set :repository,        "git@github.com:waferbaby/usesthis.git"
set :runner,            "d"
set :scm,               :git
set :user,              "d"
set :use_sudo,          false

role :app, "usesthis.com"
role :web, "usesthis.com"

namespace :deploy do
    task :start, :roles => :app do
        run "cd #{deploy_to}/current && nohup /var/lib/gems/1.8/bin/thin -s 3 -R config/rack.ru start"
    end
    
    task :stop, :roles => :app do
        run "cd #{deploy_to}/current && nohup /var/lib/gems/1.8/bin/thin -s 3 -R config/rack.ru stop"
    end
    
    task :restart, :roles => :app do
        deploy.stop
        deploy.start
    end
    
    task :symlink do
      run "ln -nfs #{shared_path}/config/application.yml #{current_path}/config/application.yml"
    end
end

after "deploy:update", "deploy:symlink"