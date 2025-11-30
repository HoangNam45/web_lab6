<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Student List - MVC</title>
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
        max-width: 1200px;
        margin: 0 auto;
        background: white;
        border-radius: 10px;
        padding: 30px;
        box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
        margin-bottom: 20px;
      }

      h1 {
        color: #333;
        margin-bottom: 10px;
        font-size: 32px;
      }

      .subtitle {
        color: #666;
        margin-bottom: 30px;
        font-style: italic;
      }

      .message {
        padding: 15px;
        margin-bottom: 20px;
        border-radius: 5px;
        font-weight: 500;
      }

      .success {
        background-color: #d4edda;
        color: #155724;
        border: 1px solid #c3e6cb;
      }

      .error {
        background-color: #f8d7da;
        color: #721c24;
        border: 1px solid #f5c6cb;
      }

      .btn {
        display: inline-block;
        padding: 12px 24px;
        text-decoration: none;
        border-radius: 5px;
        font-weight: 500;
        transition: all 0.3s;
        border: none;
        cursor: pointer;
        font-size: 14px;
      }

      .btn-primary {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
      }

      .btn-primary:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
      }

      .btn-secondary {
        background-color: #6c757d;
        color: white;
      }

      .btn-danger {
        background-color: #dc3545;
        color: white;
        padding: 8px 16px;
        font-size: 13px;
      }

      .btn-danger:hover {
        background-color: #c82333;
      }

      table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
      }

      thead {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
      }

      th,
      td {
        padding: 15px;
        text-align: left;
        border-bottom: 1px solid #ddd;
      }

      th {
        font-weight: 600;
        text-transform: uppercase;
        font-size: 13px;
        letter-spacing: 0.5px;
      }

      tbody tr {
        transition: background-color 0.2s;
      }

      tbody tr:hover {
        background-color: #f8f9fa;
      }

      .actions {
        display: flex;
        gap: 10px;
      }

      .empty-state {
        text-align: center;
        padding: 60px 20px;
        color: #999;
      }

      .empty-state-icon {
        font-size: 64px;
        margin-bottom: 20px;
      }

      .search-box {
        background-color: #f8f9fa;
        border: 2px solid #e0e0e0;
        border-radius: 8px;
        padding: 20px;
        margin-bottom: 25px;
      }

      .search-box form {
        display: flex;
        gap: 10px;
        align-items: center;
        flex-wrap: wrap;
      }

      .search-box input[type="text"] {
        flex: 1;
        min-width: 250px;
        padding: 12px 15px;
        border: 2px solid #ddd;
        border-radius: 5px;
        font-size: 14px;
        transition: border-color 0.3s;
      }

      .search-box input[type="text"]:focus {
        outline: none;
        border-color: #667eea;
      }

      .btn-search {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        padding: 12px 24px;
        border: none;
        border-radius: 5px;
        font-weight: 500;
        cursor: pointer;
        transition: all 0.3s;
        font-size: 14px;
      }

      .btn-search:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
      }

      .btn-clear {
        background-color: #6c757d;
        color: white;
        padding: 12px 24px;
        border: none;
        border-radius: 5px;
        font-weight: 500;
        cursor: pointer;
        transition: all 0.3s;
        text-decoration: none;
        display: inline-block;
        font-size: 14px;
      }

      .btn-clear:hover {
        background-color: #5a6268;
      }

      .search-result-message {
        background-color: #e7f3ff;
        color: #004085;
        padding: 12px 20px;
        border-radius: 5px;
        margin-bottom: 20px;
        border-left: 4px solid #667eea;
        font-weight: 500;
      }

      .search-result-message strong {
        color: #667eea;
      }

      .filter-sort-controls {
        display: flex;
        gap: 15px;
        margin-bottom: 20px;
        flex-wrap: wrap;
      }

      .filter-box {
        flex: 1;
        min-width: 300px;
        background-color: #f8f9fa;
        border: 2px solid #e0e0e0;
        border-radius: 8px;
        padding: 15px;
      }

      .filter-box form {
        display: flex;
        gap: 10px;
        align-items: center;
        flex-wrap: wrap;
      }

      .filter-box label {
        font-weight: 600;
        color: #555;
        font-size: 14px;
      }

      .filter-box select {
        padding: 10px 15px;
        border: 2px solid #ddd;
        border-radius: 5px;
        font-size: 14px;
        min-width: 200px;
        cursor: pointer;
        transition: border-color 0.3s;
      }

      .filter-box select:focus {
        outline: none;
        border-color: #667eea;
      }

      .btn-filter {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        padding: 10px 20px;
        border: none;
        border-radius: 5px;
        font-weight: 500;
        cursor: pointer;
        transition: all 0.3s;
        font-size: 14px;
      }

      .btn-filter:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
      }

      .filter-active {
        background-color: #e7f3ff;
        color: #004085;
        padding: 8px 15px;
        border-radius: 5px;
        font-size: 13px;
        border-left: 3px solid #667eea;
        font-weight: 500;
      }

      th a {
        color: white;
        text-decoration: none;
        display: flex;
        align-items: center;
        gap: 5px;
        transition: opacity 0.2s;
      }

      th a:hover {
        opacity: 0.8;
      }

      .sort-indicator {
        font-size: 12px;
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
      <h1>📚 Student Management System</h1>
      <p class="subtitle">MVC Pattern with Jakarta EE & JSTL</p>

      <!-- Success Message -->
      <c:if test="${not empty param.message}">
        <div class="message success">✅ ${param.message}</div>
      </c:if>

      <!-- Error Message -->
      <c:if test="${not empty param.error}">
        <div class="message error">❌ ${param.error}</div>
      </c:if>

      <!-- Search Box -->
      <div class="search-box">
        <form action="student" method="get">
          <input type="hidden" name="action" value="search" />
          <input
            type="text"
            name="keyword"
            value="${keyword}"
            placeholder="🔍 Search by student code, name, or email..."
            autocomplete="off"
          />
          <button type="submit" class="btn btn-search">🔍 Search</button>
          <c:if test="${not empty keyword}">
            <a href="student?action=list" class="btn btn-clear">
              ❌ Clear Search
            </a>
          </c:if>
        </form>
      </div>

      <!-- Search Results Message -->
      <c:if test="${not empty keyword}">
        <div class="search-result-message">
          🔍 Search results for: <strong>"${keyword}"</strong>
        </div>
      </c:if>

      <div class="filter-sort-controls">
        <div class="filter-box">
          <form action="student" method="get">
            <input type="hidden" name="action" value="list" />
            <label>📋 Filter by Major:</label>
            <select name="major" onchange="this.form.submit()">
              <option value="all" ${empty major || major == 'all' ? 'selected' : ''}>All Majors</option>
              <option value="Computer Science" ${major == 'Computer Science' ? 'selected' : ''}>Computer Science</option>
              <option value="Information Technology" ${major == 'Information Technology' ? 'selected' : ''}>Information Technology</option>
              <option value="Software Engineering" ${major == 'Software Engineering' ? 'selected' : ''}>Software Engineering</option>
              <option value="Business Administration" ${major == 'Business Administration' ? 'selected' : ''}>Business Administration</option>
            </select>
            <c:if test="${not empty major && major != 'all'}">
              <a href="student?action=list" class="btn btn-clear">❌ Clear Filter</a>
            </c:if>
          </form>
        </div>

        <c:if test="${not empty major && major != 'all'}">
          <div class="filter-active">
            📌 Showing: <strong>${major}</strong>
          </div>
        </c:if>
      </div>

      <!-- Add New Student Button - Admin only -->
      <c:if test="${sessionScope.role eq 'admin'}">
        <div style="margin-bottom: 20px">
          <a href="student?action=new" class="btn btn-primary">
            ➕ Add New Student
          </a>
        </div>
      </c:if>

      <!-- Student Table -->
      <c:choose>
        <c:when test="${not empty students}">
          <table>
            <thead>
              <tr>
                <th>
                  <a href="student?action=list&sortBy=id&order=${sortBy == 'id' && order == 'asc' ? 'desc' : 'asc'}${not empty major && major != 'all' ? '&major=' += major : ''}">
                    ID
                    <c:if test="${sortBy == 'id'}">
                      <span class="sort-indicator">${order == 'asc' ? '▲' : '▼'}</span>
                    </c:if>
                  </a>
                </th>
                <th>
                  <a href="student?action=list&sortBy=student_code&order=${sortBy == 'student_code' && order == 'asc' ? 'desc' : 'asc'}${not empty major && major != 'all' ? '&major=' += major : ''}">
                    Student Code
                    <c:if test="${sortBy == 'student_code'}">
                      <span class="sort-indicator">${order == 'asc' ? '▲' : '▼'}</span>
                    </c:if>
                  </a>
                </th>
                <th>
                  <a href="student?action=list&sortBy=full_name&order=${sortBy == 'full_name' && order == 'asc' ? 'desc' : 'asc'}${not empty major && major != 'all' ? '&major=' += major : ''}">
                    Full Name
                    <c:if test="${sortBy == 'full_name'}">
                      <span class="sort-indicator">${order == 'asc' ? '▲' : '▼'}</span>
                    </c:if>
                  </a>
                </th>
                <th>
                  <a href="student?action=list&sortBy=email&order=${sortBy == 'email' && order == 'asc' ? 'desc' : 'asc'}${not empty major && major != 'all' ? '&major=' += major : ''}">
                    Email
                    <c:if test="${sortBy == 'email'}">
                      <span class="sort-indicator">${order == 'asc' ? '▲' : '▼'}</span>
                    </c:if>
                  </a>
                </th>
                <th>
                  <a href="student?action=list&sortBy=major&order=${sortBy == 'major' && order == 'asc' ? 'desc' : 'asc'}${not empty major && major != 'all' ? '&major=' += major : ''}">
                    Major
                    <c:if test="${sortBy == 'major'}">
                      <span class="sort-indicator">${order == 'asc' ? '▲' : '▼'}</span>
                    </c:if>
                  </a>
                </th>
                <c:if test="${sessionScope.role eq 'admin'}">
                  <th>Actions</th>
                </c:if>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="student" items="${students}">
                <tr>
                  <td>${student.id}</td>
                  <td><strong>${student.studentCode}</strong></td>
                  <td>${student.fullName}</td>
                  <td>${student.email}</td>
                  <td>${student.major}</td>
                  <c:if test="${sessionScope.role eq 'admin'}">
                    <td>
                      <div class="actions">
                        <a
                          href="student?action=edit&id=${student.id}"
                          class="btn btn-secondary"
                        >
                          ✏️ Edit
                        </a>
                        <a
                          href="student?action=delete&id=${student.id}"
                          class="btn btn-danger"
                          onclick="return confirm('Are you sure you want to delete this student?')"
                        >
                          🗑️ Delete
                        </a>
                      </div>
                    </td>
                  </c:if>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </c:when>
        <c:otherwise>
          <div class="empty-state">
            <div class="empty-state-icon">📭</div>
            <h3>No students found</h3>
            <p>Start by adding a new student</p>
          </div>
        </c:otherwise>
      </c:choose>
    </div>
  </body>
</html>
