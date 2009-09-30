load 'deploy' if respond_to?(:namespace)

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
        run "cd #{current_path} && nohup /var/lib/gems/1.8/bin/thin -s 3 -R usesthis.ru start"
        run "cd #{current_path} && nohup /var/lib/gems/1.8/bin/thin -s 1 -p 4000 -R admin.ru start"
    end
    
    task :stop, :roles => :app do
        run "cd #{current_path} && nohup /var/lib/gems/1.8/bin/thin -s 3 -R usesthis.ru stop"
        run "cd #{current_path} && nohup /var/lib/gems/1.8/bin/thin -s 1 -p 4000 -R admin.ru stop"
    end
    
    task :restart, :roles => :app do
        deploy.stop
        deploy.start
    end
    
    task :symlink do
      run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
      run "ln -nfs #{shared_path}/config/auth.yml #{release_path}/config/auth.yml"
    end
end

after "deploy:update", "deploy:symlink"