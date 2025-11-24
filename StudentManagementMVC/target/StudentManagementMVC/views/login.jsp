<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Login</title>
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
        display: flex;
        justify-content: center;
        align-items: center;
        padding: 20px;
      }

      .login-container {
        background: white;
        border-radius: 12px;
        box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
        padding: 40px;
        width: 100%;
        max-width: 420px;
      }

      .login-header {
        text-align: center;
        margin-bottom: 30px;
      }

      .login-header h1 {
        color: #333;
        font-size: 32px;
        margin-bottom: 8px;
      }

      .login-header p {
        color: #666;
        font-size: 16px;
      }

      .alert {
        padding: 12px 16px;
        border-radius: 6px;
        margin-bottom: 20px;
        font-size: 14px;
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

      form {
        margin-bottom: 24px;
      }

      .form-group {
        margin-bottom: 20px;
      }

      label {
        display: block;
        margin-bottom: 6px;
        color: #333;
        font-weight: 500;
        font-size: 14px;
      }

      input[type="text"],
      input[type="password"] {
        width: 100%;
        padding: 12px 16px;
        border: 2px solid #ddd;
        border-radius: 6px;
        font-size: 15px;
        transition: all 0.3s ease;
      }

      input[type="text"]:focus,
      input[type="password"]:focus {
        outline: none;
        border-color: #667eea;
        box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
      }

      .checkbox-group {
        display: flex;
        align-items: center;
        margin-bottom: 20px;
      }

      input[type="checkbox"] {
        margin-right: 8px;
        cursor: pointer;
      }

      .checkbox-group label {
        margin: 0;
        cursor: pointer;
        font-weight: normal;
      }

      button[type="submit"] {
        width: 100%;
        padding: 14px;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        border: none;
        border-radius: 6px;
        font-size: 16px;
        font-weight: 600;
        cursor: pointer;
        transition: transform 0.2s ease, box-shadow 0.2s ease;
      }

      button[type="submit"]:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
      }

      button[type="submit"]:active {
        transform: translateY(0);
      }

      .demo-credentials {
        background-color: #f5f5f5;
        border-radius: 8px;
        padding: 16px;
        margin-top: 24px;
      }

      .demo-credentials h4 {
        color: #333;
        font-size: 14px;
        margin-bottom: 10px;
      }

      .demo-credentials p {
        color: #666;
        font-size: 13px;
        margin: 6px 0;
      }

      .demo-credentials strong {
        color: #667eea;
      }
    </style>
  </head>
  <body>
    <div class="login-container">
      <div class="login-header">
        <h1>🔐 Login</h1>
        <p>Student Management System</p>
      </div>

      <!-- TODO: Display error message if exists -->
      <c:if test="${not empty error}">
        <div class="alert alert-error">❌ ${error}</div>
      </c:if>

      <!-- TODO: Display success message from URL parameter -->
      <c:if test="${not empty param.message}">
        <div class="alert alert-success">✅ ${param.message}</div>
      </c:if>

      <!-- Login form -->
      <form action="login" method="post">
        <!-- Username field -->
        <div class="form-group">
          <label for="username">Username</label>
          <input
            type="text"
            id="username"
            name="username"
            value="${username}"
            placeholder="Enter your username"
            required
            autofocus
          />
        </div>

        <!-- Password field -->
        <div class="form-group">
          <label for="password">Password</label>
          <input
            type="password"
            id="password"
            name="password"
            placeholder="Enter your password"
            required
          />
        </div>

        <!-- Remember me checkbox -->
        <div class="checkbox-group">
          <input type="checkbox" id="remember" name="remember" />
          <label for="remember">Remember me</label>
        </div>

        <!-- Submit button -->
        <button type="submit">🔓 Login</button>
      </form>

      <!-- Display demo credentials -->
      <div class="demo-credentials">
        <h4>Demo Credentials:</h4>
        <p><strong>Admin:</strong> admin / password123</p>
        <p><strong>User:</strong> john / password123</p>
      </div>
    </div>
  </body>
</html>
