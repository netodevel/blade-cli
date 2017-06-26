class NewProject
    def init(name_project, package)
        command = "mvn archetype:generate -DgroupId=#{package} -DartifactId=#{name_project} -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false"
        puts command
        system(command)
        generate_main(name_project, package)
    end

    def generate_main(name_project, package)
        text = File.read("template_main.txt")
        new_contents = text.gsub("${package}", package)
        package_path = package.gsub(".", "/")
            File.open("#{name_project}/src/main/java/#{package_path}/Application.java", "w") {|file| file.puts new_contents }
    end
end

new_project = NewProject.new
new_project.init("my-project", "com.example.myapp")





