package servlets.admin.radii;

import db.RadiusQueries;
import db.SystemQueries;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/radii/list")
public class RadiusListServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int delete_id = Integer.parseInt(request.getParameter("id"));
            RadiusQueries.delete(delete_id);
            response.sendRedirect("list");
        } catch (NumberFormatException ex) {
            doGet(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        try {
            int system_id = Integer.parseInt(request.getParameter("system_id_filter"));
            request.setAttribute("radii", RadiusQueries.selectBySystem(system_id));
        } catch (NumberFormatException e) {
            request.setAttribute("radii", RadiusQueries.selectAll());
        }
        request.setAttribute("systems", SystemQueries.selectAll());
        request.getRequestDispatcher("radiusList.jsp").forward(request, response);
    }
}
