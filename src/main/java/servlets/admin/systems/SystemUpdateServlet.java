package servlets.admin.systems;

import db.SystemQueries;
import model.AASystem;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/systems/update")
public class SystemUpdateServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        int id = Integer.parseInt(request.getParameter("id"));
        AASystem system = SystemQueries.get(id);
        String name = request.getParameter("name");
        double rocketSpeed;
        try {
            rocketSpeed = Double.parseDouble(request.getParameter("rocketSpeed"));
        } catch (NumberFormatException | NullPointerException e) {
            request.setAttribute("message", "Неверно введены данные!");
            doGet(request, response);
            return;
        }

        if (name.trim().isEmpty() ||
                rocketSpeed <= 0) {
            request.setAttribute("message", "Неверно введены данные!");
            doGet(request, response);
            return;
        }
        system.setName(name);
        system.setRocketSpeed(rocketSpeed);
        SystemQueries.update(system);

        response.sendRedirect("list");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        int id = Integer.parseInt(request.getParameter("id"));
        request.setAttribute("system", SystemQueries.get(id));
        request.getRequestDispatcher("systemUpdate.jsp").forward(request, response);
    }
}
