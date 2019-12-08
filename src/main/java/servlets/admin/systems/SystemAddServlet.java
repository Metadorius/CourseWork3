package servlets.admin.systems;

import db.DivisionQueries;
import db.SystemQueries;
import model.AASystem;
import model.Division;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/systems/add")
public class SystemAddServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
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
        SystemQueries.add(new AASystem(name, rocketSpeed));
        response.sendRedirect("list");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        request.getRequestDispatcher("systemAdd.jsp").forward(request, response);
    }
}
