class TemplateController
    def template_to_string
        template = '
package ${package}.controller;

import com.blade.mvc.annotation.Path;
import com.blade.mvc.http.HttpMethod;
import com.blade.mvc.annotation.Route;
import com.blade.mvc.http.Request;
import com.blade.mvc.http.Response;

@Path
public class ${name_controller}Controller {

    @Route(value = {"/${name_controller_lowercase}", "/${name_controller_lowercase}"}, method = HttpMethod.GET)
    public void index(Request request, Response response) {
        response.text("hello controller");
    }
    
}
'
    end

end
