require 'rubygems'
require 'daemons'

pwd = Dir.pwd
Daemons.run_proc('app.rb', {:dir_mode => :normal, :dir => pwd}) do
Dir.chdir(pwd)
exec "ruby app.rb -p 6020"
end

