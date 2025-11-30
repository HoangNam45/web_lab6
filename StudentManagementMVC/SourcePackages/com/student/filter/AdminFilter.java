package com.student.filter;

import com.student.model.User;
import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;
import java.io.IOException;

@WebFilter(filterName = "AdminFilter", urlPatterns = {"/student"})
public class AdminFilter implements Filter {
    
    private static final String[] ADMIN_ACTIONS = {
        "new",
        "insert",
        "edit",
        "update",
        "delete"
    };
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("AdminFilter initialized - protecting admin-only actions");
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        String action = httpRequest.getParameter("action");
        
        
        if (isAdminAction(action)) {
            
            HttpSession session = httpRequest.getSession(false);
            User user = null;
            
            if (session != null) {
                user = (User) session.getAttribute("user");
            }
            if (user != null && user.isAdmin()) {
                chain.doFilter(request, response);
            } else {
                String contextPath = httpRequest.getContextPath();
                httpResponse.sendRedirect(contextPath + "/student?action=list&error=Access denied. Admin privileges required.");
            }
        } else {
            chain.doFilter(request, response);
        }
    }
    
    @Override
    public void destroy() {
        System.out.println("AdminFilter destroyed");
    }
    
    private boolean isAdminAction(String action) {
        if (action == null || action.trim().isEmpty()) {
            return false;
        }
        for (String adminAction : ADMIN_ACTIONS) {
            if (adminAction.equalsIgnoreCase(action)) {
                return true;
            }
        }
        return false;
    }
}