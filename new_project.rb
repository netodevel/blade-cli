class NewProject
    def init(name_project, package)
        command = "mvn archetype:generate -DgroupId=#{package} -DartifactId=#{name_project} -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false"
        puts command
        if directory_exists?(name_project)
            puts "error: already existing project"
        else
            system(command)
            generate_main(name_project, package)
            generate_pom(name_project, package)
        end
    end

    def generate_main(name_project, package)
        text = File.read("template_main.txt")
        new_contents = text.gsub("${package}", package)
        package_path = package.gsub(".", "/")
            File.open("#{name_project}/src/main/java/#{package_path}/Application.java", "w") {|file| file.puts new_contents }
    end

    def generate_pom(name_project, package)
        text = File.read("template_pom.txt")
        new_contents = text.gsub("${package}", package)
        new_contents = new_contents.gsub("${name_project}", name_project)
        File.open("#{name_project}/pom.xml", "w") {|file| file.puts new_contents }
    end

    def directory_exists?(directory)
        File.directory?(directory)
    end
end

new_project = NewProject.new
new_project.init("my-project-2", "com.example.myapp")





