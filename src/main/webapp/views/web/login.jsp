<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Nhập - SHOPPING ONLINE</title>
    <!-- Bootstrap 5 CSS & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #eef2f7 0%, #f8f9fa 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px 0;
        }
        .auth-card {
            border: none;
            border-radius: 16px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.06);
            width: 100%;
            max-width: 440px;
        }
        .auth-brand {
            letter-spacing: 0.5px;
        }
        .input-group-text {
            background-color: #f8f9fa;
        }
    </style>
</head>
<body>

<div class="auth-card card p-4 bg-white">
    <div class="text-center mb-4">
        <a href="<c:url value='/home'/>" class="text-decoration-none">
            <h4 class="fw-bold text-dark auth-brand mb-1">
                <i class="bi bi-cart3 text-warning me-1"></i>SHOPPING ONLINE
            </h4>
        </a>
        <p class="text-muted small mb-0">Đăng nhập tài khoản để tiếp tục mua sắm</p>
    </div>

    <!-- Thông báo lỗi hoặc thông báo từ Controller -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show small py-2" role="alert">
            <i class="bi bi-exclamation-triangle-fill me-1"></i> ${error}
            <button type="button" class="btn-close py-2" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${not empty message}">
        <div class="alert alert-success alert-dismissible fade show small py-2" role="alert">
            <i class="bi bi-check-circle-fill me-1"></i> ${message}
            <button type="button" class="btn-close py-2" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <form action="<c:url value='/login'/>" method="post">
        <!-- Tên đăng nhập -->
        <div class="mb-3">
            <label for="username" class="form-label small fw-semibold text-secondary">Tên đăng nhập</label>
            <div class="input-group">
                <span class="input-group-text"><i class="bi bi-person text-muted"></i></span>
                <input type="text" class="form-control" id="username" name="username" value="${username}" placeholder="Nhập username" required autofocus>
            </div>
        </div>

        <!-- Mật khẩu -->
        <div class="mb-3">
            <div class="d-flex justify-content-between align-items-center mb-1">
                <label for="password" class="form-label small fw-semibold text-secondary mb-0">Mật khẩu</label>
                <a href="<c:url value='/forgot-password'/>" class="small text-decoration-none">Quên mật khẩu?</a>
            </div>
            <div class="input-group">
                <span class="input-group-text"><i class="bi bi-lock text-muted"></i></span>
                <input type="password" class="form-control" id="password" name="password" placeholder="Nhập mật khẩu" required>
                <button class="btn btn-outline-secondary" type="button" onclick="togglePassword('password', 'eyeIcon')">
                    <i class="bi bi-eye" id="eyeIcon"></i>
                </button>
            </div>
        </div>

        <!-- Ghi nhớ đăng nhập -->
        <div class="mb-4 form-check">
            <input type="checkbox" class="form-check-input" id="rememberMe" name="rememberMe" value="true">
            <label class="form-check-label small text-muted" for="rememberMe">Ghi nhớ đăng nhập</label>
        </div>

        <!-- Nút Đăng nhập -->
        <button type="submit" class="btn btn-primary w-100 py-2 fw-semibold shadow-sm mb-3">
            <i class="bi bi-box-arrow-in-right me-1"></i> Đăng Nhập
        </button>

        <div class="text-center">
            <span class="small text-muted">Chưa có tài khoản? </span>
            <a href="<c:url value='/register'/>" class="small fw-semibold text-decoration-none">Đăng ký ngay</a>
        </div>
    </form>

    <div class="text-center mt-4 pt-3 border-top">
        <a href="<c:url value='/home'/>" class="text-secondary small text-decoration-none">
            <i class="bi bi-arrow-left me-1"></i> Quay về trang chủ
        </a>
    </div>
</div>

<!-- Script ẩn/hiện mật khẩu & Bootstrap Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function togglePassword(inputId, iconId) {
        const input = document.getElementById(inputId);
        const icon = document.getElementById(iconId);
        if (input.type === 'password') {
            input.type = 'text';
            icon.classList.replace('bi-eye', 'bi-eye-slash');
        } else {
            input.type = 'password';
            icon.classList.replace('bi-eye-slash', 'bi-eye');
        }
    }
</script>
</body>
</html>