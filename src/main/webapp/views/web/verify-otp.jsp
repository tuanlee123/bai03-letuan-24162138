<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác Thực OTP - SHOPPING ONLINE</title>
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
        .otp-input {
            letter-spacing: 8px;
            font-size: 1.5rem;
            text-align: center;
            font-weight: bold;
        }
    </style>
</head>
<body>
<div class="auth-card card p-4 bg-white">
    <div class="text-center mb-4">
        <div class="bg-primary-subtle text-primary d-inline-flex p-3 rounded-circle mb-2">
            <i class="bi bi-shield-check fs-2"></i>
        </div>
        <h4 class="fw-bold text-dark mb-1">Xác Thực Mã OTP</h4>
        <p class="text-muted small mb-0">Chúng tôi đã gửi mã xác nhận 6 số đến email của bạn</p>
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show small py-2" role="alert">
            <i class="bi bi-exclamation-triangle-fill me-1"></i> ${error}
            <button type="button" class="btn-close py-2" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <form action="<c:url value='/verify-otp'/>" method="post">
        <div class="mb-4">
            <label for="otp" class="form-label small fw-semibold text-secondary text-center w-100">Nhập mã gồm 6 chữ số</label>
            <input type="text" class="form-control otp-input" id="otp" name="otp" maxlength="6" pattern="[0-9]{6}" placeholder="------" required autofocus autocomplete="one-time-code">
        </div>

        <button type="submit" class="btn btn-primary w-100 py-2 fw-semibold shadow-sm mb-3">
            <i class="bi bi-patch-check-fill me-1"></i> Xác Nhận Mã
        </button>
    </form>

    <div class="text-center pt-3 border-top">
        <span class="small text-muted">Chưa nhận được mã? </span>
        <a href="<c:url value='/forgot-password'/>" class="small fw-semibold text-decoration-none">Gửi lại</a>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>