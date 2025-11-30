<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Change Password - Student Management System</title>
    <style>
      * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
      }

      body {
        font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        min-height: 100vh;
        padding: 0;
      }

      .navbar {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        padding: 16px 40px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        margin-bottom: 20px;
      }

      .navbar h2 {
        margin: 0;
        font-size: 24px;
      }

      .navbar-right {
        display: flex;
        align-items: center;
        gap: 20px;
      }

      .user-info {
        display: flex;
        align-items: center;
        gap: 10px;
        padding: 8px 16px;
        background-color: rgba(255, 255, 255, 0.1);
        border-radius: 20px;
      }

      .role-badge {
        display: inline-block;
        padding: 4px 12px;
        border-radius: 12px;
        font-size: 11px;
        font-weight: 600;
        text-transform: uppercase;
      }

      .role-admin {
        background-color: #f5576c;
        color: white;
      }

      .role-user {
        background-color: #38ef7d;
        color: #155724;
      }

      .navbar-right a {
        color: white;
        text-decoration: none;
        padding: 8px 16px;
        border-radius: 5px;
        transition: background-color 0.3s;
      }

      .navbar-right a:hover {
        background-color: rgba(255, 255, 255, 0.2);
      }

      .container {
        max-width: 600px;
        margin: 40px auto;
        background: white;
        border-radius: 12px;
        padding: 40px;
        box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
      }

      h1 {
        color: #333;
        margin-bottom: 10px;
        font-size: 32px;
        text-align: center;
      }

      .subtitle {
        color: #666;
        margin-bottom: 30px;
        text-align: center;
      }

      .alert {
        padding: 15px;
        margin-bottom: 20px;
        border-radius: 8px;
        font-weight: 500;
      }

      .alert-error {
        background-color: #fee;
        border-left: 4px solid #f44336;
        color: #c62828;
      }

      .alert-success {
        background-color: #e8f5e9;
        border-left: 4px solid #4caf50;
        color: #2e7d32;
      }

      .form-group {
        margin-bottom: 24px;
      }

      label {
        display: block;
        margin-bottom: 8px;
        color: #333;
        font-weight: 600;
        font-size: 14px;
      }

      input[type="password"] {
        width: 100%;
        padding: 14px 16px;
        border: 2px solid #ddd;
        border-radius: 8px;
        font-size: 15px;
        transition: all 0.3s ease;
      }

      input[type="password"]:focus {
        outline: none;
        border-color: #667eea;
        box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
      }

      .password-requirements {
        background-color: #f8f9fa;
        padding: 12px;
        border-radius: 6px;
        margin-top: 10px;
        font-size: 13px;
        color: #666;
      }

      .password-requirements ul {
        margin: 8px 0 0 20px;
      }

      .password-requirements li {
        margin: 4px 0;
      }

      .btn {
        width: 100%;
        padding: 14px;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        border: none;
        border-radius: 8px;
        font-size: 16px;
        font-weight: 600;
        cursor: pointer;
        transition: transform 0.2s ease, box-shadow 0.2s ease;
      }

      .btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
      }

      .btn:active {
        transform: translateY(0);
      }

      .back-link {
        text-align: center;
        margin-top: 20px;
      }

      .back-link a {
        color: #667eea;
        text-decoration: none;
        font-weight: 500;
        transition: color 0.3s;
      }

      .back-link a:hover {
        color: #764ba2;
        text-decoration: underline;
      }

      .info-box {
        background-color: #e7f3ff;
        color: #004085;
        padding: 12px 16px;
        border-radius: 8px;
        margin-bottom: 24px;
        border-left: 4px solid #667eea;
        font-size: 14px;
      }
    </style>
  </head>
  <body>
    <!-- Navigation Bar -->
    <div class="navbar">
      <h2>📚 Student Management System</h2>
      <div class="navbar-right">
        <div class="user-info">
          <span>Welcome, ${sessionScope.user.fullName}</span>
          <span class="role-badge role-${sessionScope.role}">
            ${sessionScope.role}
          </span>
        </div>
        <a href="dashboard">Dashboard</a>
        <a href="logout">Logout</a>
      </div>
    </div>

    <div class="container">
      <h1>🔒 Change Password</h1>
      <p class="subtitle">Update your account password</p>

      <!-- Error Message -->
      <c:if test="${not empty error}">
        <div class="alert alert-error">❌ ${error}</div>
      </c:if>

      <!-- Info Box -->
      <div class="info-box">
        💡 For security reasons, please choose a strong password that you
        haven't used before.
      </div>

      <!-- Change Password Form -->
      <form action="change-password" method="post">
        <div class="form-group">
          <label for="currentPassword">Current Password</label>
          <input
            type="password"
            id="currentPassword"
            name="currentPassword"
            placeholder="Enter your current password"
            required
            autofocus
          />
        </div>

        <div class="form-group">
          <label for="newPassword">New Password</label>
          <input
            type="password"
            id="newPassword"
            name="newPassword"
            placeholder="Enter your new password"
            required
            minlength="8"
          />
          <div class="password-requirements">
            <strong>Password Requirements:</strong>
            <ul>
              <li>Minimum 8 characters long</li>
              <li>Must be different from current password</li>
            </ul>
          </div>
        </div>

        <div class="form-group">
          <label for="confirmPassword">Confirm New Password</label>
          <input
            type="password"
            id="confirmPassword"
            name="confirmPassword"
            placeholder="Re-enter your new password"
            required
            minlength="8"
          />
        </div>

        <button type="submit" class="btn">🔐 Change Password</button>
      </form>

      <div class="back-link">
        <a href="dashboard">← Back to Dashboard</a>
      </div>
    </div>
  </body>
</html>
