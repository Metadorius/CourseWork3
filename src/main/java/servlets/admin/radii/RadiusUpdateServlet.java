package servlets.admin.radii;

import db.RadiusQueries;
import db.SystemQueries;
import model.AARadius;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/radii/update")
public class RadiusUpdateServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            AARadius radius = RadiusQueries.get(id);
            int system_id;
            double height, radiusInner, radiusOuter;
            try {
                system_id = Integer.parseInt(request.getParameter("system_id"));
                height = Double.parseDouble(request.getParameter("height"));
                radiusInner = Double.parseDouble(request.getParameter("radiusInner"));
                radiusOuter = Double.parseDouble(request.getParameter("radiusOuter"));
            } catch (NumberFormatException | NullPointerException e) {
                request.setAttribute("message", "Неверно введены данные!");
                doGet(request, response);
                return;
            }

            if (height < 0 ||
                    radiusInner >= radiusOuter ||
                    radiusInner < 0) {
                request.setAttribute("message", "Неверно введены данные!");
                doGet(request, response);
                return;
            }
            radius.setAASystem(SystemQueries.get(system_id));
            radius.setHeight(height);
            radius.setRadiusInner(radiusInner);
            radius.setRadiusOuter(radiusOuter);
            RadiusQueries.update(radius);
            response.sendRedirect("list");
        } catch (Exception ex) {
            request.setAttribute("message", "Во время обработки запроса произошла ошибка: " + ex.toString());
            doGet(request, response);
            throw new RuntimeException(ex);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            request.setCharacterEncoding("UTF-8");
            int id = Integer.parseInt(request.getParameter("id"));
            request.setAttribute("systems", SystemQueries.selectAll());
            request.setAttribute("radius", RadiusQueries.get(id));
            request.getRequestDispatcher("radiusUpdate.jsp").forward(request, response);
        } catch (NumberFormatException ex) {
            response.sendRedirect("list");
        }
    }
}
