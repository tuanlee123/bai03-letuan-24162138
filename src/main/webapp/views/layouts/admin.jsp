<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property='title'/> - Quản Trị Hệ Thống</title>
    <!-- Template Bootstrap 5 CSS & Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .admin-sidebar {
            width: 260px;
            min-height: 100vh;
            background-color: #212529;
        }
        .admin-sidebar .nav-link {
            color: #adb5bd;
            border-radius: 6px;
            margin-bottom: 4px;
            padding: 10px 16px;
        }
        .admin-sidebar .nav-link:hover {
            color: #ffffff;
            background-color: #343a40;
        }
        .admin-sidebar .nav-link.active {
            color: #ffffff;
            background-color: #0d6efd;
        }
    </style>
    <sitemesh:write property='head'/>
</head>
<body>
    <div class="d-flex">
        <!-- Sidebar Bên Trái -->
        <aside class="admin-sidebar p-3 d-flex flex-column flex-shrink-0 shadow">
            <a href="<c:url value='/admin/home'/>" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto text-white text-decoration-none">
                <i class="bi bi-shield-shaded fs-3 text-warning me-2"></i>
                <span class="fs-5 fw-bold">Admin Panel</span>
            </a>
            <hr class="text-secondary">
            <ul class="nav nav-pills flex-column mb-auto">
                <li class="nav-item">
                    <a href="<c:url value='/admin/home'/>" class="nav-link">
                        <i class="bi bi-speedometer2 me-2"></i> Bảng điều khiển
                    </a>
                </li>
                <li>
                    <a href="<c:url value='/admin/categories'/>" class="nav-link">
                        <i class="bi bi-tags me-2"></i> Quản lý Danh mục
                    </a>
                </li>
                <li>
                    <a href="<c:url value='/admin/products'/>" class="nav-link">
                        <i class="bi bi-box-seam me-2"></i> Quản lý Sản phẩm
                    </a>
                </li>
                <li>
                    <a href="<c:url value='/admin/users'/>" class="nav-link">
                        <i class="bi bi-people me-2"></i> Quản lý Người dùng
                    </a>
                </li>
                <li class="mt-4 border-top border-secondary pt-3">
                    <a href="<c:url value='/home'/>" class="nav-link text-warning">
                        <i class="bi bi-arrow-left-circle me-2"></i> Xem ngoài Web
                    </a>
                </li>
            </ul>
            <hr class="text-secondary">
            <div class="dropdown">
                <a href="#" class="d-flex align-items-center text-white text-decoration-none dropdown-toggle" data-bs-toggle="dropdown">
                    <i class="bi bi-person-circle fs-5 me-2"></i>
                    <strong>${sessionScope.account.fullname != null ? sessionScope.account.fullname : 'Quản trị viên'}</strong>
                </a>
                <ul class="dropdown-menu dropdown-menu-dark text-small shadow">
                    <li><a class="dropdown-item" href="<c:url value='/profile'/>">Hồ sơ cá nhân</a></li>
                    <li><hr class="dropdown-divider"></li>
                    <li><a class="dropdown-item text-danger" href="<c:url value='/logout'/>">Đăng xuất</a></li>
                </ul>
            </div>
        </aside>

        <!-- Main Body Nội Dung Bên Phải -->
        <div class="flex-grow-1 d-flex flex-column min-vh-100">
            <!-- Top Header Admin -->
            <header class="bg-white shadow-sm py-2 px-4 d-flex justify-content-between align-items-center border-bottom">
                <span class="text-secondary small">Hệ thống quản lý bán hàng MVC &bull; Jakarta EE 10</span>
                <div>
                    <span class="badge bg-success-subtle text-success border border-success-subtle px-3 py-2">
                        <i class="bi bi-check-circle me-1"></i> Hệ thống sẵn sàng
                    </span>
                </div>
            </header>

            <!-- Vùng nhúng nội dung trang con từ SiteMesh -->
            <main class="p-4 flex-grow-1">
                <sitemesh:write property='body'/>
            </main>

            <!-- Footer Admin -->
            <footer class="bg-white border-top text-center py-3 text-muted small mt-auto">
                © 2026 Shopping Service MVC - Admin Dashboard
            </footer>
        </div>
    </div>

    <!-- Bootstrap 5 Bundle JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>