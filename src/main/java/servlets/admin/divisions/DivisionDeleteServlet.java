package servlets.admin.divisions;

import db.DivisionQueries;
import model.Division;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/divisions/delete")
public class DivisionDeleteServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");

        Division division = DivisionQueries.get(id);
        if (division.getName().equals(name)) {
            DivisionQueries.delete(division.getId());
            response.sendRedirect("list");
        } else {
            request.setAttribute("message", "Неверно введено название!");
            doGet(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            request.setCharacterEncoding("UTF-8");
            int id = Integer.parseInt(request.getParameter("id"));
            request.setAttribute("division", DivisionQueries.get(id));
            request.getRequestDispatcher("divisionDelete.jsp").forward(request, response);
        } catch (NumberFormatException ex) {
            response.sendRedirect("list");
        }
    }
}
