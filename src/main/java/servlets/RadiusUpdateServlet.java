package servlets;

import db.RadiusQueries;
import db.SystemQueries;
import model.AARadius;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/radiusUpdate")
public class RadiusUpdateServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
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
        response.sendRedirect("radiusList");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        request.setAttribute("systems", SystemQueries.selectAll());
        request.getRequestDispatcher("radiusUpdate.jsp").forward(request, response);
    }
}
