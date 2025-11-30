package com.student.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;
import java.io.IOException;

@WebFilter(filterName = "AuthFilter", urlPatterns = {"/*"})
public class AuthFilter implements Filter {
    
    private static final String[] PUBLIC_URLS = {
        "/login",
        "/logout",
        ".css",
        ".js",
        ".png",
        ".jpg",
        ".jpeg",
        ".gif",
        ".ico"
    };
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("AuthFilter initialized - protecting application routes");
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        String requestURI = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();
        
        String path = requestURI.substring(contextPath.length());
        
        if (isPublicUrl(path)) {
            chain.doFilter(request, response);
            return;
        }
        
        HttpSession session = httpRequest.getSession(false);
        
        boolean isLoggedIn = (session != null && session.getAttribute("user") != null);
        
        
        if (isLoggedIn) {
            chain.doFilter(request, response);
        } else {
            httpResponse.sendRedirect(contextPath + "/login");
        }
    }
    
    @Override
    public void destroy() {
        System.out.println("AuthFilter destroyed");
    }
    
    private boolean isPublicUrl(String path) {
        if (path.equals("/") || path.isEmpty()) {
            return true;
        }
        
        if (path.equals("/login") || path.startsWith("/login")) {
            return true;
        }
        
        if (path.equals("/logout") || path.startsWith("/logout")) {
            return true;
        }

        for (String publicUrl : PUBLIC_URLS) {
            if (publicUrl.startsWith(".") && path.endsWith(publicUrl)) {
                return true;
            }
        }
        
        return false;
    }
}
