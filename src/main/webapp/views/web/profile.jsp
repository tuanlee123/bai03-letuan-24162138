<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hồ Sơ Cá Nhân</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-light d-flex flex-column min-vh-100">

    <!-- Header Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top shadow-sm">
        <div class="container">
            <a class="navbar-brand fw-bold text-warning" href="<c:url value='/home'/>">
                <i class="bi bi-cart3 me-2"></i>SHOPPING ONLINE
            </a>
            <div class="ms-auto d-flex align-items-center gap-2">
                <a href="<c:url value='/home'/>" class="btn btn-outline-light btn-sm"><i class="bi bi-house-door me-1"></i> Trang chủ</a>
                <a href="<c:url value='/logout'/>" class="btn btn-danger btn-sm"><i class="bi bi-box-arrow-right me-1"></i> Đăng xuất</a>
            </div>
        </div>
    </nav>

    <!-- Nội dung Profile -->
    <div class="container my-5 flex-grow-1">
        <div class="row justify-content-center">
            <div class="col-md-7 col-lg-6">
                <div class="card border-0 shadow-sm">
                    <div class="card-header bg-white py-3 text-center border-bottom">
                        <h4 class="fw-bold text-primary mb-0"><i class="bi bi-person-lines-fill me-2"></i>Thông Tin Hồ Sơ Cá Nhân</h4>
                    </div>
                    <div class="card-body p-4">
                        <form action="<c:url value='/profile/update'/>" method="post" enctype="multipart/form-data">
                            <div class="text-center mb-4">
                                <c:choose>
                                    <c:when test="${not empty user.images and user.images.startsWith('http')}">
                                        <img id="avatarPreview" src="${user.images}" class="rounded-circle border p-1 shadow-sm" style="width: 100px; height: 100px; object-fit: cover;">
                                    </c:when>
                                    <c:when test="${not empty user.images}">
                                        <img id="avatarPreview" src="<c:url value='/image?fname=${user.images}'/>" class="rounded-circle border p-1 shadow-sm" style="width: 100px; height: 100px; object-fit: cover;">
                                    </c:when>
                                    <c:otherwise>
                                        <img id="avatarPreview" src="https://via.placeholder.com/100?text=Avatar" class="rounded-circle border p-1 shadow-sm" style="width: 100px; height: 100px; object-fit: cover;">
                                    </c:otherwise>
                                </c:choose>
                                <div class="mt-2">
                                    <label for="image" class="btn btn-sm btn-outline-secondary">
                                        <i class="bi bi-camera me-1"></i> Đổi ảnh đại diện
                                    </label>
                                    <input type="file" id="image" name="image" accept="image/*" class="d-none" onchange="previewAvatar(this)">
                                </div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-semibold">Tên đăng nhập</label>
                                <input type="text" class="form-control" name="username" value="${user.username}" readonly>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-semibold">Địa chỉ Email</label>
                                <input type="email" class="form-control" name="email" value="${user.email}" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-semibold">Họ và tên</label>
                                <input type="text" class="form-control" name="fullname" value="${user.fullname}" required>
                            </div>

                            <div class="mb-4">
                                <label class="form-label fw-semibold">Số điện thoại</label>
                                <input type="text" class="form-control" name="phone" value="${user.phone}">
                            </div>

                            <button type="submit" class="btn btn-primary w-100 py-2 fw-semibold shadow-sm">
                                <i class="bi bi-check2-circle me-1"></i> Lưu Thay Đổi
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <footer class="bg-white text-center py-3 border-top mt-auto text-muted small">
        &copy; 2026 BAI01 - SHOPPING ONLINE
    </footer>

<script>
    function previewAvatar(input) {
        if (input.files && input.files[0]) {
            const reader = new FileReader();
            reader.onload = e => {
                document.getElementById('avatarPreview').src = e.target.result;
            };
            reader.readAsDataURL(input.files[0]);
        }
    }
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>