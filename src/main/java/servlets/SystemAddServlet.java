package servlets;

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

@WebServlet("/systemAdd")
public class SystemAddServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String name = request.getParameter("name");
        double radiusInnerLow, radiusOuterLow, radiusInnerMed, radiusOuterMed, radiusInnerHigh, radiusOuterHigh;
        try {
            radiusInnerLow = Double.parseDouble(request.getParameter("radiusInnerLow"));
            radiusOuterLow = Double.parseDouble(request.getParameter("radiusOuterLow"));
            radiusInnerMed = Double.parseDouble(request.getParameter("radiusInnerMed"));
            radiusOuterMed = Double.parseDouble(request.getParameter("radiusOuterMed"));
            radiusInnerHigh = Double.parseDouble(request.getParameter("radiusInnerHigh"));
            radiusOuterHigh = Double.parseDouble(request.getParameter("radiusOuterHigh"));
        } catch (NumberFormatException | NullPointerException e) {
            request.setAttribute("message", "Неверно введены данные!");
            doGet(request, response);
            return;
        }

        if (name.trim().isEmpty() ||
                radiusInnerLow > radiusOuterLow ||
                radiusInnerMed > radiusOuterMed ||
                radiusInnerHigh > radiusOuterHigh ||
                radiusInnerLow < 0 || radiusInnerMed < 0 || radiusInnerHigh < 0) {
            request.setAttribute("message", "Неверно введены данные!");
            doGet(request, response);
            return;
        }
        SystemQueries.add(new AASystem(name, radiusInnerLow, radiusOuterLow, radiusInnerMed, radiusOuterMed, radiusInnerHigh, radiusOuterHigh));
        response.sendRedirect("systemList");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        request.getRequestDispatcher("systemAdd.jsp").forward(request, response);
    }
}
