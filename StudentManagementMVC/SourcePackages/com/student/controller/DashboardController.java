package com.student.controller;

import com.student.dao.StudentDAO;
import com.student.model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/dashboard")
public class DashboardController extends HttpServlet {
    
    private StudentDAO studentDAO;
    
    @Override
    public void init() {
        // Initialize studentDAO
        studentDAO = new StudentDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get user from session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            // Not logged in, redirect to login
            response.sendRedirect("login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        
        // Get statistics (total students)
        int totalStudents = studentDAO.getTotalStudents();
        int activeStudents = studentDAO.getActiveStudents();
        int inactiveStudents = totalStudents - activeStudents;
        
        // Set attributes
        request.setAttribute("totalStudents", totalStudents);
        request.setAttribute("activeStudents", activeStudents);
        request.setAttribute("inactiveStudents", inactiveStudents);
        request.setAttribute("user", user);
        
        // Forward to dashboard.jsp
        request.getRequestDispatcher("/views/dashboard.jsp").forward(request, response);
    }
}
