<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm Người Dùng Mới - Admin</title>
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
                <li class="breadcrumb-item active">Thêm mới</li>
            </ol>
        </nav>

        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card border-0 shadow-sm">
                    <div class="card-header bg-white py-3 border-bottom">
                        <h5 class="fw-bold text-primary mb-0"><i class="bi bi-person-plus-fill me-2"></i>Thêm Mới Tài Khoản</h5>
                    </div>
                    <div class="card-body p-4">
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger py-2 mb-3">
                                <i class="bi bi-exclamation-circle me-1"></i>${error}
                            </div>
                        </c:if>

                        <form action="<c:url value='/admin/user/insert'/>" method="post" enctype="multipart/form-data">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold">Tên đăng nhập <span class="text-danger">*</span></label>
                                    <input type="text" name="username" class="form-control" placeholder="Ví dụ: nguyenvana" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold">Mật khẩu <span class="text-danger">*</span></label>
                                    <input type="password" name="password" class="form-control" placeholder="Nhập mật khẩu" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold">Họ và tên <span class="text-danger">*</span></label>
                                    <input type="text" name="fullname" class="form-control" placeholder="Nguyễn Văn A" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold">Email <span class="text-danger">*</span></label>
                                    <input type="email" name="email" class="form-control" placeholder="email@example.com" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold">Số điện thoại</label>
                                    <input type="text" name="phone" class="form-control" placeholder="0901234567">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold">Vai trò <span class="text-danger">*</span></label>
                                    <select name="roleid" class="form-select">
                                        <option value="2" selected>Khách hàng (User)</option>
                                        <option value="1">Quản trị viên (Admin)</option>
                                    </select>
                                </div>
                                <div class="col-12">
                                    <label class="form-label fw-semibold">Ảnh đại diện</label>
                                    <input type="file" name="image" class="form-control" accept="image/*" onchange="previewImg(this)">
                                    <div class="mt-3 text-center d-none" id="wrapPreview">
                                        <img id="previewImgTag" src="#" alt="Preview" class="rounded-circle border p-1" style="width: 90px; height: 90px; object-fit: cover;">
                                    </div>
                                </div>
                            </div>

                            <div class="d-flex gap-2 mt-4 pt-2 border-top">
                                <button type="submit" class="btn btn-primary px-4 fw-semibold">
                                    <i class="bi bi-check-circle me-1"></i> Lưu Người Dùng
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
                document.getElementById('wrapPreview').classList.remove('d-none');
            };
            reader.readAsDataURL(input.files[0]);
        }
    }
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>