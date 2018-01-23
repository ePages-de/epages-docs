# config valid for current version and patch releases of Capistrano
lock "~> 3.8.1"

server '18.195.76.160', roles: [:web, :app, :db], primary: true

set :application, "epages_docs_staging"
set :repo_url, "git@github.com:ePages-de/epages-docs.git"
set :rbenv_ruby, '2.4.2'
set :user, 'deploy'
set :branch, 'master'
set :pty,             true
set :use_sudo,        false
set :stage,           :production
set :deploy_via,      :remote_cache
set :deploy_to,       "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub) }

namespace :deploy do
  after :updated, :jekyll_tasks do
    on roles(:app)do
      invoke 'jekyll:build'
    end
  end
end

namespace :jekyll do
  desc 'Build and generate _site with jekyll'
  task :build do
    on roles(:app) do
      execute("cd '#{release_path}'; docker-compose build")
      execute("cd '#{release_path}'; docker-compose up")
      execute("sudo chown -R deploy:deploy /home/#{fetch(:user)}/apps/#{fetch(:application)}")
    end
  end

  desc 'Add the old docs to _site'
  task :move_docs do
    on roles(:app) do
      execute("mkdir -p #{release_path}/../../epages_devblog_staging/current/_site/apps")
      execute("mkdir -p #{release_path}/../../epages_devblog_staging/current/_site/soap")
      execute("cp -r #{release_path}/_site/apps/* #{release_path}/../../../epages_devblog_staging/current/_site/apps")
      execute("cp -r #{release_path}/_site/soap/* #{release_path}/../../../epages_devblog_staging/current/_site/soap")
      execute("rm -fr #{release_path}/_site/assets/fonts")
      execute("cp -r #{release_path}/_site/assets/* #{release_path}/../../../epages_devblog_staging/current/_site/assets")
      execute("sudo chown -R deploy:deploy /home/#{fetch(:user)}/apps/#{fetch(:application)}")
      execute("sudo chown -R deploy:deploy /home/#{fetch(:user)}/apps/epages_devblog_staging")
    end
  end

  desc 'Remove images'
  task :clean_up do
    on roles(:app)do
      execute("docker rmi -f $(docker images -a -q); true")
      execute("docker system prune -f; true")
    end
  end

  after :build, :move_docs
  after :move_docs, :clean_up
end
