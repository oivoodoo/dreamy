set :stages, %w(staging production testing)

require 'capistrano/ext/multistage'

set :scm, :git
set :repository,  "git@github.com:oivoodoo/dreamy.git"

default_run_options[:pty] = true
set :ssh_options, { :forward_agent => true }
set :user, "hosting_nosimoe"

role :web, "hydrogen.locum.ru"                          # Your HTTP server, Apache/etc
role :app, "hydrogen.locum.ru"                          # This may be the same as your `Web` server

set :deploy_via, :remote_cache
set :use_sudo, false
set :spinner, false

namespace :deploy do
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end
  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
  task :migrate do
    run "cd #{current_path}; /var/lib/gems/1.8/bin/rake db:migrate RAILS_ENV=#{stage}"
  end
end

namespace :configuration do
  task :create_links do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
  task :create_assets do
    run "cd #{current_path} ; /var/lib/gems/1.8/bin/rake asset:packager:build_all"
  end
  task :remove_assets do
    run "cd #{current_path} ; /var/lib/gems/1.8/bin/rake asset:packager:delete_all"
  end
end

after :deploy, "deploy:restart"
after :deploy, "configuration:create_links"
#after :deploy, "configuration:remove_assets"
#after :deploy, "configuration:create_assets"
after :deploy, "deploy:migrate"

