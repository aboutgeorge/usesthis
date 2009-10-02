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
    %w(start stop restart).each do |action|
        task action.to_sym do
            find_and_execute_task("thin:#{action}")
        end
    end
    
    task :restart, :roles => :app do
        deploy.stop
        deploy.start
    end
    
    task :symlink_config do
      run "ln -nfs #{shared_path}/usesthis.yml #{deploy_to}/current/main/usesthis.yml"
      run "ln -nfs #{shared_path}/usesthis.yml #{deploy_to}/current/admin/usesthis.yml"
    end
end

namespace :thin do
    %w(start stop restart).each do |action|
        task action.to_sym, :roles => :app do
            run "/var/lib/gems/1.8/bin/thin #{action} -R rack.ru -c #{deploy_to}/current/main -C #{deploy_to}/current/main/thin.yml"
            run "/var/lib/gems/1.8/bin/thin #{action} -R rack.ru -c #{deploy_to}/current/admin -C #{deploy_to}/current/admin/thin.yml"
        end
    end
end

after "deploy:symlink", "deploy:symlink_config"