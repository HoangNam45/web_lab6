<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Dashboard - Student Management System</title>
    <style>
      * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
      }

      body {
        font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
        background-color: #f5f7fa;
        min-height: 100vh;
      }

      /* Navigation Bar */
      .navbar {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        padding: 16px 40px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
      }

      .navbar-brand {
        font-size: 24px;
        font-weight: bold;
      }

      .navbar-user {
        display: flex;
        align-items: center;
        gap: 20px;
      }

      .user-info {
        display: flex;
        align-items: center;
        gap: 12px;
      }

      .user-avatar {
        width: 40px;
        height: 40px;
        background-color: white;
        color: #667eea;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: bold;
        font-size: 18px;
      }

      .user-details {
        text-align: right;
      }

      .user-name {
        font-weight: 600;
        font-size: 15px;
      }

      .user-role {
        font-size: 12px;
        opacity: 0.9;
        text-transform: uppercase;
      }

      .role-badge {
        display: inline-block;
        padding: 3px 10px;
        background-color: rgba(255, 255, 255, 0.2);
        border-radius: 12px;
        font-size: 11px;
        font-weight: 600;
      }

      .logout-btn {
        background-color: rgba(255, 255, 255, 0.2);
        color: white;
        border: 1px solid rgba(255, 255, 255, 0.3);
        padding: 8px 20px;
        border-radius: 6px;
        cursor: pointer;
        text-decoration: none;
        font-size: 14px;
        transition: all 0.3s ease;
      }

      .logout-btn:hover {
        background-color: rgba(255, 255, 255, 0.3);
        transform: translateY(-1px);
      }

      /* Main Content */
      .container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 40px 20px;
      }

      /* Welcome Section */
      .welcome-section {
        background: white;
        border-radius: 12px;
        padding: 30px;
        margin-bottom: 30px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
      }

      .welcome-section h1 {
        color: #333;
        font-size: 32px;
        margin-bottom: 8px;
      }

      .welcome-section p {
        color: #666;
        font-size: 16px;
      }

      /* Statistics Cards */
      .stats-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
        gap: 24px;
        margin-bottom: 30px;
      }

      .stat-card {
        background: white;
        border-radius: 12px;
        padding: 24px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
        transition: transform 0.3s ease, box-shadow 0.3s ease;
      }

      .stat-card:hover {
        transform: translateY(-4px);
        box-shadow: 0 4px 16px rgba(0, 0, 0, 0.12);
      }

      .stat-card-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 16px;
      }

      .stat-icon {
        width: 50px;
        height: 50px;
        border-radius: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 24px;
      }

      .stat-icon.blue {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      }

      .stat-icon.green {
        background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
      }

      .stat-icon.orange {
        background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
      }

      .stat-value {
        font-size: 36px;
        font-weight: bold;
        color: #333;
        margin-bottom: 4px;
      }

      .stat-label {
        color: #666;
        font-size: 14px;
        text-transform: uppercase;
        letter-spacing: 0.5px;
      }

      /* Quick Actions */
      .actions-section {
        background: white;
        border-radius: 12px;
        padding: 30px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
      }

      .actions-section h2 {
        color: #333;
        font-size: 24px;
        margin-bottom: 20px;
      }

      .actions-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 16px;
      }

      .action-btn {
        display: flex;
        align-items: center;
        gap: 12px;
        padding: 16px 20px;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        text-decoration: none;
        font-size: 15px;
        font-weight: 500;
        transition: all 0.3s ease;
      }

      .action-btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
      }

      .action-btn.secondary {
        background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
      }

      .action-btn.tertiary {
        background: linear-gradient(135deg, #ee0979 0%, #ff6a00 100%);
      }

      .action-icon {
        font-size: 20px;
      }

      /* Admin-only section */
      .admin-only {
        border-top: 2px solid #f0f0f0;
        margin-top: 24px;
        padding-top: 24px;
      }

      .admin-badge {
        display: inline-block;
        background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
        color: white;
        padding: 4px 12px;
        border-radius: 12px;
        font-size: 12px;
        font-weight: 600;
        margin-left: 10px;
      }
    </style>
  </head>
  <body>
    <!-- Navigation Bar -->
    <nav class="navbar">
      <div class="navbar-brand">📚 Student Management System</div>
      <div class="navbar-user">
        <div class="user-info">
          <div class="user-avatar">
            ${user.fullName.substring(0, 1).toUpperCase()}
          </div>
          <div class="user-details">
            <div class="user-name">${user.fullName}</div>
            <div class="user-role">
              <span class="role-badge">${user.role}</span>
            </div>
          </div>
        </div>
        <a href="logout" class="logout-btn">🚪 Logout</a>
      </div>
    </nav>

    <!-- Main Content -->
    <div class="container">
      <!-- Welcome Section -->
      <div class="welcome-section">
        <h1>👋 Welcome back, ${user.fullName}!</h1>
        <p>
          Here's what's happening with your student management system today.
        </p>
      </div>

      <!-- Statistics Cards -->
      <div class="stats-grid">
        <div class="stat-card">
          <div class="stat-card-header">
            <div>
              <div class="stat-value">${totalStudents}</div>
              <div class="stat-label">Total Students</div>
            </div>
            <div class="stat-icon blue">👥</div>
          </div>
        </div>

        <div class="stat-card">
          <div class="stat-card-header">
            <div>
              <div class="stat-value">${activeStudents}</div>
              <div class="stat-label">Active Students</div>
            </div>
            <div class="stat-icon green">✅</div>
          </div>
        </div>

        <div class="stat-card">
          <div class="stat-card-header">
            <div>
              <div class="stat-value">${inactiveStudents}</div>
              <div class="stat-label">Inactive Students</div>
            </div>
            <div class="stat-icon orange">⛔</div>
          </div>
        </div>
      </div>

      <!-- Quick Actions -->
      <div class="actions-section">
        <h2>⚡ Quick Actions</h2>
        <div class="actions-grid">
          <a href="student?action=list" class="action-btn">
            <span class="action-icon">📋</span>
            <span>View All Students</span>
          </a>

          <c:if test="${user.role eq 'admin'}">
            <a href="student?action=new" class="action-btn secondary">
              <span class="action-icon">➕</span>
              <span>Add New Student</span>
            </a>
          </c:if>

          <a href="student?action=search" class="action-btn tertiary">
            <span class="action-icon">🔍</span>
            <span>Search Students</span>
          </a>
        </div>

        <!-- Admin-only Actions -->
        <c:if test="${user.role eq 'admin'}">
          <div class="admin-only">
            <h2>
              🔧 Admin Actions <span class="admin-badge">ADMIN ONLY</span>
            </h2>
            <div class="actions-grid">
              <a href="student?action=export" class="action-btn">
                <span class="action-icon">📥</span>
                <span>Export Data</span>
              </a>

              <a href="student?action=reports" class="action-btn secondary">
                <span class="action-icon">📊</span>
                <span>Generate Reports</span>
              </a>

              <a href="users?action=manage" class="action-btn tertiary">
                <span class="action-icon">👤</span>
                <span>Manage Users</span>
              </a>
            </div>
          </div>
        </c:if>
      </div>
    </div>
  </body>
</html>
