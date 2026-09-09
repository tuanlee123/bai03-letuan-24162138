<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bảng Điều Khiển Quản Trị - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .sidebar { width: 250px; min-height: 100vh; background-color: #212529; }
        .sidebar .nav-link { color: #adb5bd; border-radius: 6px; margin-bottom: 4px; }
        .sidebar .nav-link:hover, .sidebar .nav-link.active { color: #fff; background-color: #343a40; }
        .main-wrapper { flex: 1; background-color: #f8f9fa; min-height: 100vh; }
        .stat-card { border-radius: 12px; transition: transform 0.2s ease; }
        .stat-card:hover { transform: translateY(-3px); }
    </style>
</head>
<body>
<div class="d-flex">
    <!-- Sidebar Admin -->
    <div class="sidebar p-3 d-flex flex-column text-white">
        <a href="<c:url value='/admin/home'/>" class="d-flex align-items-center mb-3 text-warning text-decoration-none fs-5 fw-bold">
            <i class="bi bi-shield-lock-fill me-2"></i> ADMIN PANEL
        </a>
        <hr class="text-secondary">
        <ul class="nav nav-pills flex-column mb-auto">
            <li>
                <a href="<c:url value='/admin/home'/>" class="nav-link active">
                    <i class="bi bi-speedometer2 me-2"></i> Bảng điều khiển
                </a>
            </li>
            <li>
                <a href="<c:url value='/admin/categories'/>" class="nav-link">
                    <i class="bi bi-folder2-open me-2"></i> Quản lý danh mục
                </a>
            </li>
            <li>
                <a href="<c:url value='/admin/products'/>" class="nav-link">
                    <i class="bi bi-box-seam me-2"></i> Quản lý sản phẩm
                </a>
            </li>
            <!-- Đã bổ sung mục Quản lý người dùng vào đây -->
            <li>
                <a href="<c:url value='/admin/users'/>" class="nav-link">
                    <i class="bi bi-people-fill me-2"></i> Quản lý người dùng
                </a>
            </li>
            <li>
                <a href="<c:url value='/home'/>" class="nav-link text-info">
                    <i class="bi bi-globe me-2"></i> Xem ngoài Web
                </a>
            </li>
        </ul>
        <hr class="text-secondary">
        <a href="<c:url value='/logout'/>" class="btn btn-outline-danger btn-sm w-100">
            <i class="bi bi-box-arrow-right me-1"></i> Đăng xuất
        </a>
    </div>

    <!-- Main Content -->
    <div class="main-wrapper p-4">
        <div class="mb-4">
            <h3 class="fw-bold text-dark mb-0">Tổng Quan Hệ Thống</h3>
            <p class="text-muted">Chào mừng Quản trị viên đến với hệ thống quản lý bán hàng</p>
        </div>

        <div class="row g-4 mb-4">
            <div class="col-md-4">
                <div class="card stat-card border-0 shadow-sm bg-primary text-white p-3">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <p class="mb-1 text-white-50 small text-uppercase fw-semibold">Danh Mục</p>
                            <h4 class="fw-bold mb-0">Quản Lý Nhóm Hàng</h4>
                        </div>
                        <i class="bi bi-folder2 fs-1 opacity-75"></i>
                    </div>
                    <a href="<c:url value='/admin/categories'/>" class="text-white text-decoration-none mt-3 d-inline-block small">
                        Xem chi tiết <i class="bi bi-arrow-right ms-1"></i>
                    </a>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card stat-card border-0 shadow-sm bg-success text-white p-3">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <p class="mb-1 text-white-50 small text-uppercase fw-semibold">Kho Hàng</p>
                            <h4 class="fw-bold mb-0">Quản Lý Sản Phẩm</h4>
                        </div>
                        <i class="bi bi-box-seam fs-1 opacity-75"></i>
                    </div>
                    <a href="<c:url value='/admin/products'/>" class="text-white text-decoration-none mt-3 d-inline-block small">
                        Xem chi tiết <i class="bi bi-arrow-right ms-1"></i>
                    </a>
                </div>
            </div>
            <!-- Bổ sung thêm card Quản lý người dùng cho cân đối giao diện -->
            <div class="col-md-4">
                <div class="card stat-card border-0 shadow-sm bg-warning text-dark p-3">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <p class="mb-1 text-dark-50 small text-uppercase fw-semibold">Thành Viên</p>
                            <h4 class="fw-bold mb-0">Quản Lý Tài Khoản</h4>
                        </div>
                        <i class="bi bi-people fs-1 opacity-75"></i>
                    </div>
                    <a href="<c:url value='/admin/users'/>" class="text-dark text-decoration-none mt-3 d-inline-block small fw-bold">
                        Xem chi tiết <i class="bi bi-arrow-right ms-1"></i>
                    </a>
                </div>
            </div>
        </div>

        <div class="card border-0 shadow-sm p-4">
            <h5 class="fw-bold text-dark mb-3">Thao Tác Nhanh</h5>
            <div class="d-flex gap-2 flex-wrap">
                <a href="<c:url value='/admin/category/add'/>" class="btn btn-outline-primary">
                    <i class="bi bi-folder-plus me-1"></i> Thêm Danh Mục Mới
                </a>
                <a href="<c:url value='/admin/product/add'/>" class="btn btn-outline-success">
                    <i class="bi bi-plus-circle me-1"></i> Thêm Sản Phẩm Mới
                </a>
                <!-- Thêm nút Thêm người dùng mới -->
                <a href="<c:url value='/admin/user/add'/>" class="btn btn-outline-warning text-dark">
                    <i class="bi bi-person-plus me-1"></i> Thêm Tài Khoản Mới
                </a>
                <a href="<c:url value='/home'/>" class="btn btn-outline-secondary">
                    <i class="bi bi-box-arrow-up-right me-1"></i> Mở Trang Web Khách Hàng
                </a>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>