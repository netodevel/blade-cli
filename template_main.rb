class TemplateMain
    def template_to_string
        template = '
package ${package};
import com.blade.Blade;
import com.blade.mvc.http.Request;
import com.blade.mvc.http.Response;
import com.blade.mvc.route.RouteHandler;

public class Application {
    
    public static void main(String[] args) {
        Blade blade = Blade.me();
        blade.get("/", new RouteHandler() {
            public void handle(Request request, Response response) {
                response.text("Hello Blade");
            }
        }).start();
    }
}'
    end
end
