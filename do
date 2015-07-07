#!/usr/bin/env ruby
require 'yaml'

log = []

# Create sessions
YAML.load(DATA).each do |(session, windows)|
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

  log << session
end

unless log.empty?
  puts "Initialized #{log.map { |a| "\033[33m#{str}\033[0m" } .join ', '}"
else
  puts 'Everything up-to-date'
end

__END__
bkground:
  snucheat: |
    cd ~/snucheat
    ./app.py

irc:
  weechat: |
    cd ~
    TERM=screen-256color weechat-curses
