package servlets.admin.divisions;

import db.DivisionQueries;
import db.SystemQueries;
import misc.SMTPMailSender;
import model.Division;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/divisions/list")
public class DivisionListServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
//        System.out.println(DivisionQueries.selectAll());
//        for (Division d : DivisionQueries.selectAll()) {
//            AASystem.out.println(d.getName());
//        }
        try {
            int system_id = Integer.parseInt(request.getParameter("system_id_filter"));
            request.setAttribute("divisions", DivisionQueries.selectBySystem(system_id));
        } catch (NumberFormatException e) {
            request.setAttribute("divisions", DivisionQueries.selectAll());
        }

        request.setAttribute("systems", SystemQueries.selectAll());
        request.getRequestDispatcher("divisionList.jsp").forward(request, response);
    }
}
