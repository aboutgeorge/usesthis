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

namespace :main do
  task :start do
    run "cd #{current_path} && nohup /var/lib/gems/1.8/bin/thin -s 3 -R config/application.ru start"
  end
  
  task :stop do
    run "cd #{current_path} && nohup /var/lib/gems/1.8/bin/thin -s 3 -R config/application.ru stop"
  end
  
  task :symlink do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end  
end

namespace :admin do
  task :start do
    run "cd #{current_path} && nohup /var/lib/gems/1.8/bin/thin -s 1 -p 4000 -R config/admin.ru start"
  end

  task :stop do
    run "cd #{current_path} && nohup /var/lib/gems/1.8/bin/thin -s 1 -p 4000 -R config/admin.ru stop"
  end
  
  task :symlink do
    run "ln -nfs #{shared_path}/config/admin.yml #{release_path}/config/admin.yml"
  end
end

namespace :deploy do
    task :start, :roles => :app do
        main.start
        admin.start
    end
    
    task :stop, :roles => :app do
        main.stop
        admin.stop
    end
    
    task :restart, :roles => :app do
        deploy.stop
        deploy.start
    end    
end

after "deploy:update", "main:symlink", "admin:symlink"