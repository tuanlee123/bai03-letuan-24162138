<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cập Nhật Người Dùng - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .sidebar { width: 250px; min-height: 100vh; background-color: #212529; }
        .sidebar .nav-link { color: #adb5bd; border-radius: 6px; margin-bottom: 4px; }
        .sidebar .nav-link:hover, .sidebar .nav-link.active { color: #fff; background-color: #343a40; }
        .main-wrapper { flex: 1; background-color: #f8f9fa; min-height: 100vh; }
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
        <nav aria-label="breadcrumb" class="mb-4">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="<c:url value='/admin/home'/>" class="text-decoration-none">Bảng điều khiển</a></li>
                <li class="breadcrumb-item"><a href="<c:url value='/admin/users'/>" class="text-decoration-none">Quản lý người dùng</a></li>
                <li class="breadcrumb-item active">Chỉnh sửa</li>
            </ol>
        </nav>

        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card border-0 shadow-sm">
                    <div class="card-header bg-white py-3 border-bottom">
                        <h5 class="fw-bold text-warning text-dark mb-0"><i class="bi bi-pencil-square me-2"></i>Cập Nhật Thông Tin Tài Khoản</h5>
                    </div>
                    <div class="card-body p-4">
                        <form action="<c:url value='/admin/user/update'/>" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="id" value="${user.id}">

                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold">Tên đăng nhập</label>
                                    <input type="text" class="form-control bg-light" value="${user.username}" readonly>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold">Mật khẩu mới</label>
                                    <input type="password" name="password" class="form-control" placeholder="Để trống nếu không đổi">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold">Họ và tên <span class="text-danger">*</span></label>
                                    <input type="text" name="fullname" class="form-control" value="${user.fullname}" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold">Email <span class="text-danger">*</span></label>
                                    <input type="email" name="email" class="form-control" value="${user.email}" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold">Số điện thoại</label>
                                    <input type="text" name="phone" class="form-control" value="${user.phone}">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold">Vai trò <span class="text-danger">*</span></label>
                                    <select name="roleid" class="form-select">
                                        <option value="2" ${user.roleid == 2 ? 'selected' : ''}>Khách hàng (User)</option>
                                        <option value="1" ${user.roleid == 1 ? 'selected' : ''}>Quản trị viên (Admin)</option>
                                    </select>
                                </div>
                                <div class="col-12">
                                    <label class="form-label fw-semibold">Ảnh đại diện</label>
                                    <div class="d-flex align-items-center gap-3 mb-2">
                                        <c:choose>
                                            <c:when test="${not empty user.images and user.images.startsWith('http')}">
                                                <img id="previewImgTag" src="${user.images}" alt="${user.username}" width="65" height="65" class="rounded-circle border object-fit-cover">
                                            </c:when>
                                            <c:when test="${not empty user.images}">
                                                <img id="previewImgTag" src="<c:url value='/image?fname=${user.images}'/>" alt="${user.username}" width="65" height="65" class="rounded-circle border object-fit-cover">
                                            </c:when>
                                            <c:otherwise>
                                                <img id="previewImgTag" src="https://via.placeholder.com/65?text=User" width="65" height="65" class="rounded-circle border">
                                            </c:otherwise>
                                        </c:choose>
                                        <input type="file" name="image" class="form-control" accept="image/*" onchange="previewImg(this)">
                                    </div>
                                    <div class="form-text">Bỏ trống nếu giữ nguyên ảnh hiện tại.</div>
                                </div>
                            </div>

                            <div class="d-flex gap-2 mt-4 pt-2 border-top">
                                <button type="submit" class="btn btn-warning px-4 fw-semibold text-dark">
                                    <i class="bi bi-check2-circle me-1"></i> Cập Nhật
                                </button>
                                <a href="<c:url value='/admin/users'/>" class="btn btn-outline-secondary px-3">Quay lại</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    function previewImg(input) {
        if (input.files && input.files[0]) {
            const reader = new FileReader();
            reader.onload = e => {
                document.getElementById('previewImgTag').src = e.target.result;
            };
            reader.readAsDataURL(input.files[0]);
        }
    }
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>