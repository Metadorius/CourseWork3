package filters;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(urlPatterns = {"/admin/*"}, description = "Login Checker Filter")
public class SecurityFilter implements Filter {
    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        HttpSession session = request.getSession();

        if (!request.getRequestURI().endsWith("login") &&
                session.getAttribute("login") == null) {
            session.setAttribute("cachedUri", request.getRequestURI());
            session.setAttribute("cachedQuery", request.getQueryString());
            response.sendRedirect(request.getContextPath() + "/login");
        } else
            filterChain.doFilter(request, response);
    }
}
