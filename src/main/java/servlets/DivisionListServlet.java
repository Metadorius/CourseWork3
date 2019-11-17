package servlets;

import db.DivisionQueries;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/divisionList")
public class DivisionListServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        System.out.println(DivisionQueries.selectAll());
//        for (Division d : DivisionQueries.selectAll()) {
//            System.out.println(d.getName());
//        }
        request.setAttribute("divisions", DivisionQueries.selectAll());
        request.getRequestDispatcher("divisionList.jsp").forward(request, response);
    }
}
