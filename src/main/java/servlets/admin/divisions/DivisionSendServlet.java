package servlets.admin.divisions;

import db.DivisionQueries;
import misc.SMTPMailSender;
import model.Division;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/divisions/send")
public class DivisionSendServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        request.setAttribute("postfix", SMTPMailSender.EMAIL_POSTFIX);
        request.getRequestDispatcher("divisionSend.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String mail_addr = request.getParameter("mail_username") + "@" + SMTPMailSender.EMAIL_POSTFIX;
            String mail_password = request.getParameter("mail_password");
            String receiver = request.getParameter("receiver");

            SMTPMailSender sender = new SMTPMailSender(mail_addr, mail_password);

            StringBuilder sb = new StringBuilder();

            sb.append("<table>");

            sb.append("<tr>");
            sb.append("<td>Дивизион</td>");
            sb.append("<td>Широта</td>");
            sb.append("<td>Долгота</td>");
            sb.append("<td>ЗРК</td>");
            sb.append("</tr>");

            for (Division division : DivisionQueries.selectAll()) {
                sb.append("<tr>");
                sb.append("<td>").append(division.getName()).append("</td>");
                sb.append("<td>").append(division.getLat()).append("</td>");
                sb.append("<td>").append(division.getLng()).append("</td>");
                sb.append("<td>").append(division.getAASystem()).append("</td>");
                sb.append("</tr>");
            }
            sb.append("</table>");

            String message = sb.toString();

            sender.send("Данные таблицы \"Дивизионы\"", message, receiver);
            response.sendRedirect("list");
        } catch (Exception ex) {
            request.setAttribute("message", "Во время обработки запроса произошла ошибка: " + ex.toString());
            doGet(request, response);
            throw new RuntimeException(ex);
        }
    }
}
