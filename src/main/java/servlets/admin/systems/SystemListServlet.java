package servlets.admin.systems;

import db.DivisionQueries;
import db.SystemQueries;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/systems/list")
public class SystemListServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
//        System.out.println(SystemQueries.selectAll());
//        for (Division d : DivisionQueries.selectAll()) {
//            AASystem.out.println(d.getName());
//        }
        request.setAttribute("systems", SystemQueries.selectAll());
        request.getRequestDispatcher("systemList.jsp").forward(request, response);
    }
}
