require_relative 'string'

class Run
    def init
      print "Booting NettyServer \n".blue
      print "Blade 2.0.0 application starting in development on "
      print "http://localhost:9000 \n".green
      print "Ctrl-C to shutdown server \n".blue
      compile_all_classes()
      load_dependencies()
    end

    def load_dependencies
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
        command = "java -Dfile.encoding=UTF-8 -classpath #{path_build}#{dependencies} com.example.myapp.Application"
        system(command)
    end

    def compile_all_classes
        system("mkdir target | grep dontprintmvn | awk '{print $1}'")
        system("mkdir target/classes | grep dontprintmvn | awk '{print $1}'")
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
        command = "javac -d #{path_build} -cp #{dependencies} src/main/java/com/example/myapp/*.java"
        system(command)
    end

end
