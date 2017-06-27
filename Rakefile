require_relative 'main'
require_relative 'new_project'
require_relative 'run'

class String
  def black;          "\e[30m#{self}\e[0m" end
  def red;            "\e[31m#{self}\e[0m" end
  def green;          "\e[32m#{self}\e[0m" end
  def brown;          "\e[33m#{self}\e[0m" end
  def blue;           "\e[34m#{self}\e[0m" end
  def magenta;        "\e[35m#{self}\e[0m" end
  def cyan;           "\e[36m#{self}\e[0m" end
  def gray;           "\e[37m#{self}\e[0m" end

  def bg_black;       "\e[40m#{self}\e[0m" end
  def bg_red;         "\e[41m#{self}\e[0m" end
  def bg_green;       "\e[42m#{self}\e[0m" end
  def bg_brown;       "\e[43m#{self}\e[0m" end
  def bg_blue;        "\e[44m#{self}\e[0m" end
  def bg_magenta;     "\e[45m#{self}\e[0m" end
  def bg_cyan;        "\e[46m#{self}\e[0m" end
  def bg_gray;        "\e[47m#{self}\e[0m" end

  def bold;           "\e[1m#{self}\e[22m" end
  def italic;         "\e[3m#{self}\e[23m" end
  def underline;      "\e[4m#{self}\e[24m" end
  def blink;          "\e[5m#{self}\e[25m" end
  def reverse_color;  "\e[7m#{self}\e[27m" end
end

task :default => :blade

desc 'Create a new project Blade'
task :new do
  new_project = NewProject.new
  new_project.init("my-project-2", "com.example.myapp")
end

desc 'Run project'
task :run do
  run = Run.new
  run.init
end

desc 'Scaffold'
task :scaffold do
  puts "command scaffold"
end

desc 'Init the initial config for CLI Blade'
task :init do
  print  "Configurating...\n\n"
  chid_path = Dir.pwd
  username = %x[echo $(logname)]
  path = "/home/neto/"

  print "Appending the cli alias on your "
  print ".zshrc\n\n".blue

  print "path: #{path}"

  #~/.zshrc
  File.open(File.join(path, '.bashrc'), 'a') do |f|
    f.write "\nalias blade='rake -f #{chid_path}/Rakefile'"
  end

  print "Configuration done!\n\n"

  print "Blade Framework CLI.\n\n"

  print "To initialize the command line you can run the command: \n"
  print "$ blade\n".blue
  print "But for the "
  print "$ blade ".blue
  print "command works you must reload your .zshrc\n\n"

  print "To reload your .zshrc you can run: "
  print "source #{path}.zshrc".blue

  print "\n\nInitializing the Blade CLI..\n\n"
  Rake::Task['blade'].execute
end

desc 'Init the Blade CLI'
task :blade do
  #ruby 'main.rb'
  #Main.init
  sh 'echo Hello $(logname)', verbose: false

  puts "
  __________.__              .___       _________ .____    .___
  \\______   \\  | _____     __| _/____   \\_   ___ \\|    |   |   |
   |    |  _/  | \\__  \\   / __ |/ __ \\  /    \  \\/|    |   |   |
   |    |   \\  |__/ __ \\_/ /_/ \\  ___/  \\     \\___|    |___|   |
   |______  /____(____  /\\____ |\\___  >  \\______  /_______ \\___|
          \\/          \\/      \\/    \\/          \\/        \\/
  "
  puts "\nHow can I help you?"

  loop do
    print "> "
    line = STDIN.gets
    if line =~ /^:q/ || line =~ /^bye/ || line =~ /^quit/
      puts "Bye Bye"
      break
    end
    action = Main.init(line)

    #puts "Choose action: #{action}"

    if (action == :new)
      Rake::Task['new'].execute
    end

    if (action == :run)
      Rake::Task['run'].execute
    end

    if (action == :scaffold)
      Rake::Task['scaffold'].execute
    end

    if (action == :help)
      puts "I can help you with:"
      puts "  - new        -> Create a new project Blade"
      puts "  - run        -> Run project Blade"
      puts "  - scaffold    -> Generate CRUD Rest"
      puts "\nTell me what you need"
    end
  end
end
