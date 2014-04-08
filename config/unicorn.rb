root = "/home/mr_deployer/apps/cap3final/current"
working_directory root
pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"

listen "/tmp/unicorn.cap3final.sock"
worker_processes 2
timeout 30

# Force unicorn to look at the Gemfile in the current_path
# otherwise once we've first started a master process, it
# will always point to the first one it started.
before_exec do |server|
  ENV['BUNDLE_GEMFILE'] = "/home/mr_deployer/apps/cap3final/current/Gemfile"
end