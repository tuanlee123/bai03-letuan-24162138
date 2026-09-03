<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><sitemesh:title default="Quản Trị Hệ Thống" /></title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; display: flex; min-height: 100vh; }
        .sidebar { width: 240px; background: #2c3e50; color: #ecf0f1; padding: 20px 0; flex-shrink: 0; }
        .sidebar h3 { text-align: center; margin-bottom: 25px; font-size: 18px; color: #3498db; }
        .sidebar a { display: block; color: #bdc3c7; padding: 12px 20px; text-decoration: none; transition: 0.2s; }
        .sidebar a:hover { background: #34495e; color: #fff; }
        .main-content { flex: 1; display: flex; flex-direction: column; background: #f8f9fa; }
        .top-navbar { background: #fff; padding: 15px 25px; border-bottom: 1px solid #dee2e6; display: flex; justify-content: flex-end; align-items: center; }
        .top-navbar a { color: #dc3545; text-decoration: none; font-weight: bold; margin-left: 15px; }
        .page-body { padding: 25px; flex: 1; }
        footer { background: #fff; border-top: 1px solid #dee2e6; padding: 10px 25px; text-align: center; font-size: 13px; color: #6c757d; }
    </style>
    <sitemesh:head />
</head>
<body>

    <!-- Thanh menu trái (Sidebar) -->
    <div class="sidebar">
        <h3>ADMIN DASHBOARD</h3>
        <a href="<c:url value='/admin/products'/>">📦 Quản lý Sản phẩm</a>
        <a href="<c:url value='/admin/categories'/>">📂 Quản lý Danh mục</a>
        <a href="<c:url value='/profile'/>">👤 Hồ sơ cá nhân</a>
        <a href="<c:url value='/home'/>">🏠 Xem trang người dùng</a>
    </div>

    <!-- Khung nội dung chính -->
    <div class="main-content">
        <div class="top-navbar">
            <span>Xin chào, <b>Admin</b></span>
            <a href="<c:url value='/logout'/>">Đăng xuất</a>
        </div>

        <div class="page-body">
            <!-- Phần thân của từng trang con sẽ được chèn vào đây -->
            <sitemesh:body />
        </div>

        <footer>
            Hệ thống Quản trị - &copy; 2026 Admin Panel
        </footer>
    </div>

</body>
</html>