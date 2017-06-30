class TemplateMain
    def template_to_string
        template = '
package ${package};

import com.blade.Blade;

public class Application {
    
    public static void main(String[] args) {
        Blade.of().start(Application.class, args);
    }
    
}
'
    end
end
