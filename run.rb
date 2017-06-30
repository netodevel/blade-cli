require_relative 'string'

class Run
    def init()
      print "Booting NettyServer \n".blue
      print "Blade 2.0.0 application starting in development on "
      print "http://localhost:9000 \n".green
      print "Ctrl-C to shutdown server \n".blue
      main_class = main_config_blade()
      package_root = package_config_blade()
      compile_all_classes(package_root)
      load_dependencies(main_class)
      #run_project(main_class)
    end

    def run_project(main_class)
        system("mvn compile exec:java -Dexec.mainClass=#{main_class}")
    end

    def load_dependencies(main_class)
        dependencies = ""
        File.open('list-dependencies.txt', 'r') do |f1|
            while line = f1.gets
                path_dependency = line.split(':/')
                unless (path_dependency[1].to_s.empty?)
                    dependencies +=  ":/" + path_dependency[1].strip
                end
            end
        end
        path_build = Dir.pwd + "/target/classes"
        command = "java -Dfile.encoding=UTF-8 -classpath #{path_build}#{dependencies} #{main_class}"
        system(command)
    end

    def main_config_blade
        main_class = ""
        File.open('blade.conf', 'r') do |f1|
            while line = f1.gets
                boot_class = line.split('boot-class:')
                unless (boot_class[1].to_s.empty?)
                   main_class = boot_class[1].strip
                end
            end
        end
        return main_class
    end

    def package_config_blade
        package_root = ""
        File.open('blade.conf', 'r') do |f1|
            while line = f1.gets
                package = line.split('package:')
                unless (package[1].to_s.empty?)
                   package_root = package[1].strip
                end
            end
        end
        return package_root
    end

    def folder_target_exists?
        File.exist?("target")
    end

    def compile_all_classes(package_root)
        unless folder_target_exists?
            system("mkdir target | grep dontprintmvn | awk '{print $1}'")
            system("mkdir target/classes | grep dontprintmvn | awk '{print $1}'")
        end
        system("mvn dependency:resolve | grep dontprintmvn | awk '{print $1}'")
        system("mvn -o dependency:list -DoutputFile='list-dependencies.txt' -DoutputAbsoluteArtifactFilename=true | grep dontprintmvn | awk '{print $1}'")
        dependencies = ""
        File.open('list-dependencies.txt', 'r') do |f1|
            while line = f1.gets
                path_dependency = line.split(':/')
                unless (path_dependency[1].to_s.empty?)
                    dependencies +=  ":/" + path_dependency[1].strip
                end
            end
        end
        path_build = Dir.pwd + "/target/classes"
        command = "javac -d #{path_build} -cp #{dependencies} src/main/java/#{package_root}/*.java"
        system(command)
    end

end
