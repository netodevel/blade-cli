require_relative 'template_controller'

class Generate
    def generate_controller_clean(name_controller)
        print "create ".green 
        print "/controller/#{name_controller}Controller.java \n"
        print "route ".green 
        route = name_controller.downcase
        print "#{route} \n"
        print "Done. \n".green

        package_path = package_config_blade()
        package = package_config_blade()
        package = package.gsub("/", ".")

        template_controller = TemplateController.new
        text = template_controller.template_to_string
        new_contents = text.gsub("${package}", package)
        new_contents2 = new_contents.gsub("${name_controller}", name_controller)
        new_contents3 = new_contents2.gsub("${name_controller_lowercase}", name_controller.downcase) 

        unless directory_exists?("src/main/java/#{package_path}/controller")
            system("mkdir src/main/java/#{package_path}/controller")
        end 

        File.open("src/main/java/#{package_path}/controller/#{name_controller}Controller.java", "w") {|file| file.puts new_contents3 }
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

    def directory_exists?(directory)
        File.directory?(directory)
    end

end