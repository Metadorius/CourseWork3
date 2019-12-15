package servlets.admin.radii;

import db.RadiusQueries;
import db.SystemQueries;
import model.AARadius;
import model.AASystem;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/radii/add")
public class RadiusAddServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        try {
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
            RadiusQueries.add(new AARadius(SystemQueries.get(system_id), height, radiusInner, radiusOuter));
            response.sendRedirect("list");
        } catch (Exception ex) {
            request.setAttribute("message", "Во время обработки запроса произошла ошибка: " + ex.toString());
            doGet(request, response);
            throw new RuntimeException(ex);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        request.setAttribute("systems", SystemQueries.selectAll());
        request.getRequestDispatcher("radiusAdd.jsp").forward(request, response);
    }
}
