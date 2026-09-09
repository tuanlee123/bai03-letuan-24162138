<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Người Dùng - Admin</title>
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
            <li><a href="<c:url value='/admin/categories'/>" class="nav-link"><i class="bi bi-folder2-open me-2"></i> Quản lý danh mục</a></li>
            <li><a href="<c:url value='/admin/products'/>" class="nav-link"><i class="bi bi-box-seam me-2"></i> Quản lý sản phẩm</a></li>
            <li><a href="<c:url value='/admin/users'/>" class="nav-link active"><i class="bi bi-people me-2"></i> Quản lý người dùng</a></li>
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
                <h3 class="fw-bold text-dark mb-0">Quản Lý Người Dùng</h3>
                <small class="text-muted">Danh sách tài khoản, vai trò và phân quyền</small>
            </div>
            <a href="<c:url value='/admin/user/add'/>" class="btn btn-primary fw-semibold shadow-sm">
                <i class="bi bi-person-plus-fill me-1"></i> Thêm Người Dùng
            </a>
        </div>

        <!-- Thanh Tìm Kiếm -->
        <div class="card border-0 shadow-sm mb-4">
            <div class="card-body">
                <form action="<c:url value='/admin/users'/>" method="get" class="row g-2 align-items-center">
                    <div class="col-md-5 col-12">
                        <div class="input-group">
                            <span class="input-group-text bg-white"><i class="bi bi-search"></i></span>
                            <input type="text" name="keyword" class="form-control" 
                                   placeholder="Tìm theo username, họ tên hoặc email..." value="${keyword}">
                        </div>
                    </div>
                    <div class="col-auto">
                        <button type="submit" class="btn btn-dark px-3">Tìm kiếm</button>
                        <c:if test="${not empty keyword}">
                            <a href="<c:url value='/admin/users'/>" class="btn btn-outline-secondary">Xóa bộ lọc</a>
                        </c:if>
                    </div>
                </form>
            </div>
        </div>

        <!-- Bảng Danh Sách User -->
        <div class="card shadow-sm border-0">
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover table-striped align-middle mb-0">
                        <thead class="table-dark">
                            <tr>
                                <th class="text-center" style="width: 70px;">#ID</th>
                                <th class="text-center" style="width: 80px;">Avatar</th>
                                <th>Tài khoản</th>
                                <th>Họ và tên</th>
                                <th>Email</th>
                                <th>Số điện thoại</th>
                                <th class="text-center" style="width: 140px;">Vai trò</th>
                                <th class="text-center" style="width: 170px;">Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty userList}">
                                    <c:forEach items="${userList}" var="u">
                                        <tr>
                                            <td class="text-center fw-bold text-secondary">#${u.id}</td>
                                            <td class="text-center">
                                                <c:choose>
                                                    <c:when test="${not empty u.images and u.images.startsWith('http')}">
                                                        <img src="${u.images}" alt="${u.username}" width="45" height="45" class="rounded-circle object-fit-cover border">
                                                    </c:when>
                                                    <c:when test="${not empty u.images}">
                                                        <img src="<c:url value='/image?fname=${u.images}'/>" alt="${u.username}" width="45" height="45" class="rounded-circle object-fit-cover border">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img src="https://via.placeholder.com/45?text=User" width="45" height="45" class="rounded-circle border">
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="fw-semibold text-primary">${u.username}</td>
                                            <td class="text-dark">${not empty u.fullname ? u.fullname : '<span class=\"text-muted small\">Chưa cập nhật</span>'}</td>
                                            <td>${u.email}</td>
                                            <td>${not empty u.phone ? u.phone : '<span class=\"text-muted small\">Chưa có</span>'}</td>
                                            <td class="text-center">
                                                <span class="badge ${u.roleid == 1 ? 'bg-danger-subtle text-danger border border-danger-subtle' : 'bg-info-subtle text-dark border border-info-subtle'} px-2 py-1">
                                                    ${u.roleid == 1 ? 'Quản trị viên' : 'Khách hàng'}
                                                </span>
                                            </td>
                                            <td class="text-center">
                                                <a href="<c:url value='/admin/user/edit?id=${u.id}'/>" class="btn btn-outline-warning btn-sm me-1" title="Sửa">
                                                    <i class="bi bi-pencil-square"></i> Sửa
                                                </a>
                                                <a href="<c:url value='/admin/user/delete?id=${u.id}'/>" 
                                                   class="btn btn-outline-danger btn-sm"
                                                   onclick="return confirm('Bạn có chắc chắn muốn xóa tài khoản [${u.username}]?');" title="Xóa">
                                                    <i class="bi bi-trash"></i> Xóa
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="8" class="text-center py-5 text-muted">
                                            <i class="bi bi-person-x fs-2 d-block mb-1"></i>
                                            Không tìm thấy người dùng nào phù hợp.
                                        </td>
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