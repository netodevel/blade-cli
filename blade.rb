#!/usr/bin/env ruby
require 'optparse'
require_relative 'new_project'
require_relative 'run'
require_relative 'generate'

options = {}
action = ""
OptionParser.new do |opts|
  opts.banner =
  "
  __________.__              .___       _________ .____    .___
  \\______   \\  | _____     __| _/____   \\_   ___ \\|    |   |   |
   |    |  _/  | \\__  \\   / __ |/ __ \\  /    \  \\/|    |   |   |
   |    |   \\  |__/ __ \\_/ /_/ \\  ___/  \\     \\___|    |___|   |
   |______  /____(____  /\\____ |\\___  >  \\______  /_______ \\___|
          \\/          \\/      \\/    \\/          \\/        \\/
        Usage: blade [options]
  "

  #string as argument
  opts.on("-n", "--new project") do |name_project|
    options[:name_project] = name_project
    action = "new"
  end

  opts.on("-g", "--generate type_generate") do |generate|
    action = "generate"
    options[:generate] = generate
  end

  opts.on("-s", "--[no-]verbose", "Run project") do |verbose|
    action = "run"
    options[:verbose] = verbose
  end

  opts.on("-p", "--set port server") do |port|
    action = "port"
    options[:port] = port
  end

  #Boolean as argument
  opts.on("-v", "--[no-]verbose", "Run verbosely") do |verbose|
    options[:verbose] = verbose
    puts "blade 2.0.0"
  end

  opts.on("-h", "--help", "Show this help") do |v|
    puts opts
  end

end.parse!

if (action == "new")
    new_project = NewProject.new
    new_project.init(options[:name_project], ARGV[0])
end

if (action == "generate")
  if (options[:generate]) == "controller"
    generate_controller = Generate.new
    generate_controller.generate_controller_clean(ARGV[0])
  end
end

if (action == "run")
    run = Run.new
    run.init
end
