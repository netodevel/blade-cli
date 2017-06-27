class Run

    def init
      compile_all_classes()
      load_dependencies()
    end

    def load_dependencies
        system('mvn dependency:resolve')
        system('mvn -o dependency:list -DoutputFile="list-dependencies.txt" -DoutputAbsoluteArtifactFilename=true')
        dependencies = ""
        File.open('list-dependencies.txt', 'r') do |f1|
            while line = f1.gets
                path_dependency = line.split(':/')
                unless (path_dependency[1].to_s.empty?)
                    dependencies +=  ":/" + path_dependency[1].strip
                end
            end
        end
        puts dependencies
        path_build = Dir.pwd + "/target/classes"
        command = "java -Dfile.encoding=UTF-8 -classpath #{path_build}#{dependencies} com.example.myapp.Application"
        puts command
        system(command)
    end

    def compile_all_classes
      system('mvn -o dependency:list -DoutputFile="list-dependencies.txt" -DoutputAbsoluteArtifactFilename=true')
      dependencies = ""
      File.open('list-dependencies.txt', 'r') do |f1|
          while line = f1.gets
              path_dependency = line.split(':/')
              unless (path_dependency[1].to_s.empty?)
                  dependencies +=  ":/" + path_dependency[1].strip
              end
          end
      end
      puts dependencies
      path_build = Dir.pwd + "/target/classes"
      command = "javac -d #{path_build} -cp #{dependencies} src/main/java/com/example/myapp/*.java"
      puts command
      system(command)
    end

end

run = Run.new
run.init
