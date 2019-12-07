package servlets;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import db.DivisionQueries;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/api/divisions")
public class DivisionsApiServlet extends javax.servlet.http.HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(new GsonBuilder().excludeFieldsWithoutExposeAnnotation().create().toJson(DivisionQueries.selectAll())); //this is how simple GSON works
    }
}