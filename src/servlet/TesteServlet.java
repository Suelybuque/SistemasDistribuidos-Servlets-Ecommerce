package servlet;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;

public class TesteServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        res.getWriter().println("Servlet funcionando!");
    }
}
