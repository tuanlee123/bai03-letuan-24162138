<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quên Mật Khẩu - SHOPPING ONLINE</title>
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
    </style>
</head>
<body>
<div class="auth-card card p-4 bg-white">
    <div class="text-center mb-4">
        <div class="bg-warning-subtle text-warning d-inline-flex p-3 rounded-circle mb-2">
            <i class="bi bi-key-fill fs-2"></i>
        </div>
        <h4 class="fw-bold text-dark mb-1">Khôi Phục Mật Khẩu</h4>
        <p class="text-muted small mb-0">Nhập địa chỉ email liên kết với tài khoản của bạn để nhận mã OTP</p>
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show small py-2" role="alert">
            <i class="bi bi-exclamation-triangle-fill me-1"></i> ${error}
            <button type="button" class="btn-close py-2" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <form action="<c:url value='/forgot-password'/>" method="post">
        <div class="mb-3">
            <label for="email" class="form-label small fw-semibold text-secondary">Địa chỉ Email</label>
            <div class="input-group">
                <span class="input-group-text bg-light"><i class="bi bi-envelope text-muted"></i></span>
                <input type="email" class="form-control" id="email" name="email" value="${email}" placeholder="example@gmail.com" required autofocus>
            </div>
        </div>

        <button type="submit" class="btn btn-warning w-100 py-2 fw-bold text-dark shadow-sm mb-3">
            <i class="bi bi-send-fill me-1"></i> Gửi Mã Xác Thực OTP
        </button>
    </form>

    <div class="text-center pt-3 border-top">
        <a href="<c:url value='/login'/>" class="text-secondary small text-decoration-none">
            <i class="bi bi-arrow-left me-1"></i> Quay lại Đăng nhập
        </a>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>