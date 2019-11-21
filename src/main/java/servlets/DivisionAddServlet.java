package servlets;

import db.DivisionQueries;
import db.SystemQueries;
import model.Division;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/divisionAdd")
public class DivisionAddServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String name = request.getParameter("name");
        int system_id = Integer.parseInt(request.getParameter("system_id"));
        double lat, lng;
        try {
            lat = Double.parseDouble(request.getParameter("lat"));
            lng = Double.parseDouble(request.getParameter("lng"));
        } catch (NumberFormatException e) {
            request.setAttribute("message", "Неверно введены данные!");
            doGet(request, response);
            return;
        }
        String type = request.getParameter("type");
        if (name.trim().isEmpty() ||
            lat < -90 || lat > 90 || lng < -180 || lng > 180) { // широта 42-57 долгота 21-45
            request.setAttribute("message", "Неверно введены данные!");
            doGet(request, response);
            return;
        }
        DivisionQueries.add(new Division(name, lat, lng, SystemQueries.get(system_id)));
        response.sendRedirect("divisionList");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        request.setAttribute("systems", SystemQueries.selectAll());
        request.getRequestDispatcher("divisionAdd.jsp").forward(request, response);
    }
}
