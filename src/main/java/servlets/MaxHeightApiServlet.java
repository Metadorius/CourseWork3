package servlets;

import com.google.gson.Gson;
import db.DivisionQueries;
import db.RadiusQueries;
import model.AARadius;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/api/maxHeight")
public class MaxHeightApiServlet extends javax.servlet.http.HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        double maxHeight = 0;
        for (AARadius radius : RadiusQueries.selectAll())
            if (maxHeight < radius.getHeight())
                maxHeight = radius.getHeight();
        response.getWriter().write(new Gson().toJson(maxHeight));
    }
}