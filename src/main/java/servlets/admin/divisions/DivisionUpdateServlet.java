package servlets.admin.divisions;

import db.DivisionQueries;
import db.SystemQueries;
import model.Division;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/divisions/update")
public class DivisionUpdateServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        try {
            int id;
            int system_id;
            String name = request.getParameter("name");
            double lat, lng;
            try {
                id = Integer.parseInt(request.getParameter("id"));
                system_id = Integer.parseInt(request.getParameter("system_id"));
                lat = Double.parseDouble(request.getParameter("lat"));
                lng = Double.parseDouble(request.getParameter("lng"));
            } catch (NumberFormatException e) {
                request.setAttribute("message", "Неверно введены данные!");
                doGet(request, response);
                return;
            }
            if (name.trim().isEmpty() ||
                    lat < 43 || lat > 53 || lng < 21 || lng > 41) {
                request.setAttribute("message", "Неверно введены данные!");
                doGet(request, response);
                return;
            }
            Division division = DivisionQueries.get(id);
            division.setName(name);
            division.setLat(lat);
            division.setLng(lng);
            division.setAASystem(SystemQueries.get(system_id));
            DivisionQueries.update(division);

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
            request.setAttribute("division", DivisionQueries.get(id));
            request.setAttribute("systems", SystemQueries.selectAll());
            request.getRequestDispatcher("divisionUpdate.jsp").forward(request, response);
        } catch (NumberFormatException ex) {
            response.sendRedirect("list");
        }
    }
}
