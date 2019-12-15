package servlets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends javax.servlet.http.HttpServlet {
    public static final String USER_LOGIN = "admin";
    public static final String USER_PASSWORD = "password";
    public static final int SESSION_TIMEOUT = 15*60;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        request.setCharacterEncoding("UTF-8");
        String login = request.getParameter("login");
        String pw = request.getParameter("pw");


        if (login.equals(USER_LOGIN) && pw.equals(USER_PASSWORD)) {
            HttpSession session = request.getSession();
            session.setMaxInactiveInterval(SESSION_TIMEOUT);

            session.setAttribute("login", login);
            String redirectUri = "admin/divisions/list";

            if (session.getAttribute("cachedUri") != null) {
                redirectUri = (String) session.getAttribute("cachedUri");
                session.removeAttribute("cachedUri");
                if (session.getAttribute("cachedQuery") != null) {
                    redirectUri += "?" + session.getAttribute("cachedQuery");
                    session.removeAttribute("cachedQuery");
                }
            }
            response.sendRedirect(redirectUri);
        }
        else {
            request.setAttribute("message", "Неверно введены данные!");
            doGet(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }
}
