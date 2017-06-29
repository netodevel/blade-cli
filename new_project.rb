require_relative 'string'
require_relative 'template_main'
require_relative 'template_pom'

class NewProject
    def init(name_project, package)
        command = "mvn archetype:generate -DgroupId=#{package} -DartifactId=#{name_project} -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false | grep dontprintmvn | awk '{print $1}'"
        if directory_exists?(name_project)
            print "error: already existing project \n".red
        else
            print "Generating project...\n".blue
            system(command)
            directory_project = Dir.pwd + "/#{name_project}"
            
            print "info: project created "
            print "#{directory_project}\n".blue

            generate_config_blade(name_project, package, "Application")
            print "info: config blade is done. "
            print "#{name_project}/blade.conf\n".blue

            generate_main(name_project, package)
            print "info: generate main "
            print "#{package}.Application.java\n".blue

            generate_pom(name_project, package)
            print "info: generate "
            print "pom.xml\n".blue
            
            print "info: "
            print "done\n".green
        end
    end

    def generate_main(name_project, package)
        template_main = TemplateMain.new
        text = template_main.template_to_string 
        new_contents = text.gsub("${package}", package)
        package_path = package.gsub(".", "/")
        File.open("#{name_project}/src/main/java/#{package_path}/Application.java", "w") {|file| file.puts new_contents }
    end

    def generate_pom(name_project, package)
        template_pom = TemplatePom.new
        text = template_pom.template_to_string
        new_contents = text.gsub("${package}", package)
        new_contents = new_contents.gsub("${name_project}", name_project)
        File.open("#{name_project}/pom.xml", "w") {|file| file.puts new_contents }
    end

    def generate_config_blade(name_project, package, boot_class)
        blade_file = File.new("#{name_project}/blade.conf", "w")
        blade_file.puts("boot-class:#{package}.#{boot_class}\n")
        
        package_path = package.gsub(".", "/")
        blade_file.puts("package:#{package_path}\n")
        blade_file.close
    end 

    def directory_exists?(directory)
        File.directory?(directory)
    end
end
