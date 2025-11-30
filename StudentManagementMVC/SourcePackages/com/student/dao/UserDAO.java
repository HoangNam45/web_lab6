package com.student.dao;


import com.student.model.User;
import org.mindrot.jbcrypt.BCrypt;
import java.sql.*;

public class UserDAO {
    
    private static final String DB_URL = "jdbc:mysql://localhost:3306/student_management";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "vvhynol806";
    
    // TODO: SQL queries constants
    private static final String SQL_AUTHENTICATE = 
        "SELECT * FROM users WHERE username = ? AND is_active = TRUE";
    
    private static final String SQL_UPDATE_LAST_LOGIN = 
        "UPDATE users SET last_login = NOW() WHERE id = ?";
    
    private static final String SQL_GET_BY_ID = 
        "SELECT * FROM users WHERE id = ?";
    
    private static final String SQL_UPDATE_PASSWORD = 
        "UPDATE users SET password = ? WHERE id = ?";
    
    // TODO: Implement getConnection()
    private Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL Driver not found", e);
        }
    }
    
    // Implement authenticate()
    public User authenticate(String username, String password) {
        User user = null;
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(SQL_AUTHENTICATE)) {
            
            // 1. Query user by username
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                // 2. Get hashed password from database
                String hashedPassword = rs.getString("password");
                
                // 3. Use BCrypt.checkpw() to verify
                if (BCrypt.checkpw(password, hashedPassword)) {
                    // 4. If valid, update last login and return user
                    user = mapResultSetToUser(rs);
                    updateLastLogin(user.getId());
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        // 5. If invalid, return null
        return user;
    }
    
    // Implement updateLastLogin()
    private void updateLastLogin(int userId) {
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(SQL_UPDATE_LAST_LOGIN)) {
            
            stmt.setInt(1, userId);
            stmt.executeUpdate();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    // Implement getUserById()
    public User getUserById(int id) {
        User user = null;
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(SQL_GET_BY_ID)) {
            
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                user = mapResultSetToUser(rs);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return user;
    }
    
    // Helper method to map ResultSet to User object
    private User mapResultSetToUser(ResultSet rs) throws SQLException {
        User user = new User();
        user.setId(rs.getInt("id"));
        user.setUsername(rs.getString("username"));
        user.setPassword(rs.getString("password"));
        user.setFullName(rs.getString("full_name"));
        user.setRole(rs.getString("role"));
        user.setActive(rs.getBoolean("is_active"));
        user.setCreatedAt(rs.getTimestamp("created_at"));
        user.setLastLogin(rs.getTimestamp("last_login"));
        return user;
    }
    
    // Update user's password
    public boolean updatePassword(int userId, String newHashedPassword) {
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(SQL_UPDATE_PASSWORD)) {
            
            stmt.setString(1, newHashedPassword);
            stmt.setInt(2, userId);
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
