package com.student.controller;

import com.student.dao.UserDAO;
import com.student.model.User;
import org.mindrot.jbcrypt.BCrypt;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/change-password")
public class ChangePasswordController extends HttpServlet {
    
    private UserDAO userDAO;
    
    @Override
    public void init() {
        userDAO = new UserDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }
        
        // Show change password form
        request.getRequestDispatcher("/views/change-password.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get current user from session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }
        
        User currentUser = (User) session.getAttribute("user");
        
        // Get form parameters
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        
        // Validate input - check if fields are empty
        if (currentPassword == null || currentPassword.trim().isEmpty()) {
            request.setAttribute("error", "Current password is required");
            request.getRequestDispatcher("/views/change-password.jsp").forward(request, response);
            return;
        }
        
        if (newPassword == null || newPassword.trim().isEmpty()) {
            request.setAttribute("error", "New password is required");
            request.getRequestDispatcher("/views/change-password.jsp").forward(request, response);
            return;
        }
        
        if (confirmPassword == null || confirmPassword.trim().isEmpty()) {
            request.setAttribute("error", "Please confirm your new password");
            request.getRequestDispatcher("/views/change-password.jsp").forward(request, response);
            return;
        }
        
        // Validate current password
        if (!BCrypt.checkpw(currentPassword, currentUser.getPassword())) {
            request.setAttribute("error", "Current password is incorrect");
            request.getRequestDispatcher("/views/change-password.jsp").forward(request, response);
            return;
        }
        
        // Validate new password length (minimum 8 characters)
        if (newPassword.length() < 8) {
            request.setAttribute("error", "New password must be at least 8 characters long");
            request.getRequestDispatcher("/views/change-password.jsp").forward(request, response);
            return;
        }
        
        // Validate new password matches confirmation
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "New password and confirmation do not match");
            request.getRequestDispatcher("/views/change-password.jsp").forward(request, response);
            return;
        }
        
        // Check if new password is same as current password
        if (currentPassword.equals(newPassword)) {
            request.setAttribute("error", "New password must be different from current password");
            request.getRequestDispatcher("/views/change-password.jsp").forward(request, response);
            return;
        }
        
        // Hash new password
        String hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());
        
        // Update in database
        boolean success = userDAO.updatePassword(currentUser.getId(), hashedPassword);
        
        if (success) {
            // Update user object in session with new password
            currentUser.setPassword(hashedPassword);
            session.setAttribute("user", currentUser);
            
            // Redirect to dashboard with success message
            response.sendRedirect("dashboard?message=Password changed successfully");
        } else {
            // Show error message
            request.setAttribute("error", "Failed to update password. Please try again.");
            request.getRequestDispatcher("/views/change-password.jsp").forward(request, response);
        }
    }
}
