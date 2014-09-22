require 'yaml'

def brown str; "\033[33m#{str}\033[0m" end

Dir.chdir File.dirname __FILE__
config = YAML.load File.read 'config.yml'


## Create sessions
log = []

config.each do |(session, windows)|
  `tmux has-session -t #{session} 2> /dev/null`
  next unless $?.exitstatus == 1
  next unless windows

  # Initialize session if tmux has-session exit with 1
  windows.each_with_index do |(window, cmd), i|
    opt = ''
    opt += " -n #{window}" unless window == '-'

    if i == 0
      `tmux new-session -s #{session} -d #{opt}`
    else
      `tmux new-window -t #{session} #{opt}`
    end

    next unless cmd
    cmd.split("\n").each do |line|
      `tmux send-keys -t #{session} "#{line}" C-m`
    end
  end
  `tmux select-window -t #{session}:$`

  log.push session
end

unless log.empty?
  puts "Initialized #{log.map { |a| brown a } .join ', '}"
else
  puts 'Everything up-to-date'
end


## Create helper shell scripts
log = []

Dir.mkdir 'bin' unless Dir.exist? 'bin'

config.each do |(session)|
  path = "bin/#{session}"
  next if File.exist? path

  f = File.new path, 'w'
  f.chmod 0755
  f.write "#!/bin/sh\n"
  f.write "ruby $(dirname $0)/../go.rb #{session}\n"
  f.close

  log.push session
end

unless log.empty?
  puts "New helper: #{log.map { |a| brown a } .join ', '}"
end
