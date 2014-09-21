exit unless ARGV.length == 1
session = ARGV[0]


# Attach or switch to the target session
unless ENV['TMUX']
  `tmux attach-session -t #{session}`
else
  `tmux switch-client -t #{session}`
end


exit $?.exitstatus
