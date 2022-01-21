# config valid for current version and patch releases of Capistrano
lock "~> 3.16.0"

set :application, "korona-kapital"
set :repo_url, "git@github.com:jestradadeveloper/korona-kapital.git"


# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/deploy/korona-kapital"
#set :branch, ENV['BRANCH'] if ENV['BRANCH']
set :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }
set :linked_files, %w{config/database.yml config/master.key}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
set :keep_releases, 3
set :keep_assets, 3
set :db_local_clean, true 
set :db_remote_clean, true 

set :pty, true
namespace :deploy do

    desc 'Restart application'
    task :restart do
      on roles(:app), in: :sequence, wait: 5 do
        # Your restart mechanism here, for example:
         execute :touch, release_path.join('tmp/restart.txt')
      end
    end
  
    after :restart, :clear_cache do
      on roles(:web), in: :groups, limit: 3, wait: 10 do
        # Here we can do anything such as:
        # within release_path do
        #   execute :rake, 'cache:clear'
        # end
      end
    end
  
    after :finishing, 'deploy:cleanup'
  
  
  end

before "deploy:assets:precompile", "deploy:yarn_install"
namespace :deploy do
  desc "Run rake yarn install"
  task :yarn_install do
    on roles(:web) do
      within release_path do
        execute("cd #{release_path} && yarn install --silent --no-progress --no-audit --no-optional")
      end
    end
  end
end