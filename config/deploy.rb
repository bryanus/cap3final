# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'cap3final'
set :repo_url, 'git@github.com:bryanus/cap3final.git'

# rbenv configuration
set :rbenv_type, :user
set :rbenv_ruby, '2.1.1'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}

set :ssh_options, { forward_agent: true }

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  # desc "Check that we can access everything"
  # task :check_write_permissions do
  #   on roles(:all) do |host|
  #     if test("[ -w #{fetch(:deploy_to)} ]")
  #       info "#{fetch(:deploy_to)} is writable on #{host}"
  #     else
  #       error "#{fetch(:deploy_to)} is not writable on #{host}"
  #     end
  #   end
  # end

end
