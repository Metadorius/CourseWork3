package servlets.admin.systems;

import db.DivisionQueries;
import db.SystemQueries;
import model.AASystem;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/systems/delete")
public class SystemDeleteServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");

            AASystem system = SystemQueries.get(id);
            if (system.getName().equals(name)) {
                SystemQueries.delete(system.getId());
                response.sendRedirect("list");
            } else {
                request.setAttribute("message", "Неверно введено название!");
                doGet(request, response);
            }
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
            int cnt = DivisionQueries.selectBySystem(id).size();
            if (cnt > 0) {
                request.setAttribute("message", "На данную запись имеются ссылки в таблице дивизионов, удаление её приведёт к удалению ссылающихся записей!");
            }
            request.setAttribute("system", SystemQueries.get(id));

            request.getRequestDispatcher("systemDelete.jsp").forward(request, response);
        } catch (NumberFormatException ex) {
            response.sendRedirect("list");
        }

    }
}
