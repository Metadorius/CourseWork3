package servlets;

import db.DivisionQueries;
import db.SystemQueries;
import model.AASystem;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/systemDelete")
public class SystemDeleteServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");

        AASystem system = SystemQueries.get(id);
        if (system.getName().equals(name)) {
            SystemQueries.delete(system.getId());
            response.sendRedirect("systemList");
        } else {
            request.setAttribute("message", "Неверно введено название!");
            doGet(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        int id = Integer.parseInt(request.getParameter("id"));
        int cnt = DivisionQueries.selectBySystem(id).size();
        if (cnt > 0) {
            request.setAttribute("message", "Вы не можете удалить данную запись, т.к. на неё имеются ссылки в подчинённых таблицах!");
        } else {
            request.setAttribute("system", SystemQueries.get(id));
        }
        request.getRequestDispatcher("systemDelete.jsp").forward(request, response);
    }
}
