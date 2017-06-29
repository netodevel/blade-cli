class TemplatePom
    def template_to_string
        template = '
<project xmlns="http://maven.apache.org/POM/4.0.0"                               
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"                          xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 
        http://maven.apache.org/xsd/maven-4.0.0.xsd">

    <modelVersion>4.0.0</modelVersion>
    <groupId>${package}</groupId>
    <artifactId>${name_project}</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    
    <dependencies>
        <dependency>
            <groupId>com.bladejava</groupId>
            <artifactId>blade-mvc</artifactId>
            <version>2.0.0</version>
        </dependency>
        
        <dependency>
            <groupId>junit</groupId>
            <artifactId>junit</artifactId>
            <version>3.8.1</version>
            <scope>test</scope>
        </dependency>
    </dependencies>

</project>'
    end
end
