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
        run "cd #{current_path}/main && nohup /var/lib/gems/1.8/bin/thin -s 3 -R rack.ru start"
        run "cd #{current_path}/admin && nohup /var/lib/gems/1.8/bin/thin -s 1 -p 8080 -R rack.ru start"
    end
    
    task :stop, :roles => :app do
        run "cd #{current_path}/main && nohup /var/lib/gems/1.8/bin/thin -s 3 -R rack.ru stop"
        run "cd #{current_path}/admin && nohup /var/lib/gems/1.8/bin/thin -s 1 -p 8080 -R rack.ru stop"
    end
    
    task :restart, :roles => :app do
        deploy.stop
        deploy.start
    end
    
    task :symlink_config do
      run "ln -nfs #{shared_path}/usesthis.yml #{current_path}/main/usesthis.yml"
      run "ln -nfs #{shared_path}/usesthis.yml #{current_path}/admin/usesthis.yml"
    end
end

after "deploy:finalize_update", "deploy:symlink_config"