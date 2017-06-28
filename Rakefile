require_relative 'string'

  def username
    on_linux { return  %x[echo $USER].strip }
    on_osx   { return  %x[echo $(logname)].strip }
  end

  def platform
    %x{echo $(uname -s)}.strip
  end

  def on_linux
    if  platform =~ /Linux/
      yield
    end
  end

  def on_osx
    if  platform =~ /Darwin/
      yield
    end
  end

  def zshrc_file_exist?(zshrc_path)
    File.exist?(zshrc_path)
  end

  def zshrc_path(home_path)
    File.join(home_path, '.zshrc')
  end

  def bashrc_path(home_path)
    File.join(home_path, '.bashrc')
  end

  desc 'Init the initial config for CLI Blade'
  task :init do
    print  "Configurating...\n\n"
    blade_path = Dir.pwd
    username = username()
    path = ""

    on_linux { path = "/home/neto/"}
    on_osx   { path = "/Users/#{username.strip}/" }

    config_path = zshrc_file_exist?(path) ? zshrc_path(path) : bashrc_path(path)

    print "Appending the blade cli alias on your "

    if zshrc_file_exist?(path)
      print ".zshrc\n\n".blue
    else
      print ".bashrc\n\n".blue
    end

    File.open(config_path, 'a') do |file|
     file.write "\nalias blade='ruby #{blade_path}/blade.rb'"
    end

    print "Configuration done!\n\n"

    print "Blade Framework CLI.\n\n"

    print "To initialize the command line you can run the command: \n"
    print "$ blade\n".blue
    print "But for the "
    print "$ blade ".blue

    if zshrc_file_exist?(path)
      print "command works you must reload your .zshrc\n\n"
    else
      print "command works you must reload your .bashrc\n\n"
    end

    if zshrc_file_exist?(path)
      print "source #{config_path} \n".blue
    else
      print "source #{config_path} \n".blue
    end

    print "done.\n".green
  end
