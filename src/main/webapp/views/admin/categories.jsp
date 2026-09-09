<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Danh Mục - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .sidebar { width: 250px; min-height: 100vh; background-color: #212529; }
        .sidebar .nav-link { color: #adb5bd; border-radius: 6px; margin-bottom: 4px; }
        .sidebar .nav-link:hover, .sidebar .nav-link.active { color: #fff; background-color: #343a40; }
        .main-wrapper { flex: 1; background-color: #f8f9fa; min-height: 100vh; }
        .table > tbody > tr > td { vertical-align: middle; }
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
            <li><a href="<c:url value='/admin/home'/>" class="nav-link"><i class="bi bi-speedometer2 me-2"></i> Bảng điều khiển</a></li>
            <li><a href="<c:url value='/admin/categories'/>" class="nav-link active"><i class="bi bi-folder2-open me-2"></i> Quản lý danh mục</a></li>
            <li><a href="<c:url value='/admin/products'/>" class="nav-link"><i class="bi bi-box-seam me-2"></i> Quản lý sản phẩm</a></li>
            <li><a href="<c:url value='/admin/users'/>" class="nav-link"><i class="bi bi-people me-2"></i> Quản lý người dùng</a></li>
            <li class="mt-3 border-top border-secondary pt-3">
                <a href="<c:url value='/home'/>" class="nav-link text-info"><i class="bi bi-globe me-2"></i> Xem ngoài Web</a>
            </li>
        </ul>
        <hr class="text-secondary">
        <a href="<c:url value='/logout'/>" class="btn btn-outline-danger btn-sm w-100"><i class="bi bi-box-arrow-right me-1"></i> Đăng xuất</a>
    </div>

    <!-- Main Content -->
    <div class="main-wrapper p-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h3 class="fw-bold text-dark mb-0">Quản Lý Danh Mục</h3>
                <small class="text-muted">Danh sách các nhóm mặt hàng trong hệ thống</small>
            </div>
            <a href="<c:url value='/admin/category/add'/>" class="btn btn-primary fw-semibold shadow-sm">
                <i class="bi bi-plus-lg me-1"></i> Thêm Mới Danh Mục
            </a>
        </div>

        <!-- Thanh Tìm Kiếm -->
        <div class="card border-0 shadow-sm mb-4">
            <div class="card-body">
                <form action="<c:url value='/admin/categories'/>" method="get" class="row g-2 align-items-center">
                    <div class="col-md-5 col-12">
                        <div class="input-group">
                            <span class="input-group-text bg-white"><i class="bi bi-search"></i></span>
                            <input type="text" name="keyword" class="form-control" 
                                   placeholder="Nhập tên danh mục cần tìm..." value="${keyword}">
                        </div>
                    </div>
                    <div class="col-auto">
                        <button type="submit" class="btn btn-dark px-3">Tìm kiếm</button>
                        <c:if test="${not empty keyword}">
                            <a href="<c:url value='/admin/categories'/>" class="btn btn-outline-secondary">Xóa bộ lọc</a>
                        </c:if>
                    </div>
                </form>
            </div>
        </div>

        <!-- Bảng Danh Sách Danh Mục -->
        <div class="card shadow-sm border-0">
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover table-striped align-middle mb-0">
                        <thead class="table-dark">
                            <tr>
                                <th class="text-center" style="width: 80px;">#ID</th>
                                <th style="width: 100px;" class="text-center">Hình ảnh</th>
                                <th>Tên danh mục</th>
                                <th class="text-center" style="width: 140px;">Trạng thái</th>
                                <th class="text-center" style="width: 180px;">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty listcate}">
                                    <c:forEach items="${listcate}" var="c">
                                        <tr>
                                            <td class="text-center fw-bold text-secondary">#<c:out value="${c.categoryId}"/></td>
                                            <td class="text-center">
                                                <c:choose>
                                                    <c:when test="${not empty c.images and c.images.startsWith('http')}">
                                                        <img src="${c.images}" alt="${c.categoryname}" class="rounded border" style="width: 50px; height: 50px; object-fit: cover;">
                                                    </c:when>
                                                    <c:when test="${not empty c.images}">
                                                        <img src="<c:url value='/uploads/${c.images}'/>" alt="${c.categoryname}" class="rounded border" style="width: 50px; height: 50px; object-fit: cover;">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img src="https://via.placeholder.com/50?text=No+Img" alt="No Img" class="rounded border" style="width: 50px; height: 50px; object-fit: cover;">
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="fw-semibold text-dark">${c.categoryname}</td>
                                            <td class="text-center">
                                                <c:choose>
                                                    <c:when test="${c.status == 1}">
                                                        <span class="badge bg-success-subtle text-success border border-success-subtle px-2 py-1">Hoạt động</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-danger-subtle text-danger border border-danger-subtle px-2 py-1">Đã ẩn</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="text-center">
                                                <a href="<c:url value='/admin/category/edit?id=${c.categoryId}'/>" class="btn btn-outline-warning btn-sm me-1" title="Sửa">
                                                    <i class="bi bi-pencil-square"></i> Sửa
                                                </a>
                                                <a href="<c:url value='/admin/category/delete?id=${c.categoryId}'/>" class="btn btn-outline-danger btn-sm" onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục này?');" title="Xóa">
                                                    <i class="bi bi-trash"></i> Xóa
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="5" class="text-center py-5 text-muted">Chưa có danh mục nào phù hợp.</td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>