<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt Lại Mật Khẩu - SHOPPING ONLINE</title>
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
        <div class="bg-success-subtle text-success d-inline-flex p-3 rounded-circle mb-2">
            <i class="bi bi-lock-fill fs-2"></i>
        </div>
        <h4 class="fw-bold text-dark mb-1">Đặt Lại Mật Khẩu</h4>
        <p class="text-muted small mb-0">Tạo một mật khẩu mới an toàn cho tài khoản của bạn</p>
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show small py-2" role="alert">
            <i class="bi bi-exclamation-triangle-fill me-1"></i> ${error}
            <button type="button" class="btn-close py-2" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <form action="<c:url value='/reset-password'/>" method="post" onsubmit="return checkMatch()">
        <div class="mb-3">
            <label for="newPassword" class="form-label small fw-semibold text-secondary">Mật khẩu mới <span class="text-danger">*</span></label>
            <div class="input-group">
                <span class="input-group-text bg-light"><i class="bi bi-lock text-muted"></i></span>
                <input type="password" class="form-control" id="newPassword" name="newPassword" placeholder="Tối thiểu 6 ký tự" minlength="6" required autofocus>
            </div>
        </div>

        <div class="mb-3">
            <label for="confirmPassword" class="form-label small fw-semibold text-secondary">Xác nhận mật khẩu mới <span class="text-danger">*</span></label>
            <div class="input-group">
                <span class="input-group-text bg-light"><i class="bi bi-shield-lock text-muted"></i></span>
                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Nhập lại mật khẩu mới" minlength="6" required>
            </div>
            <div id="mismatch" class="text-danger small mt-1 d-none">Mật khẩu xác nhận không khớp!</div>
        </div>

        <button type="submit" class="btn btn-success w-100 py-2 fw-semibold shadow-sm mb-3">
            <i class="bi bi-check-circle-fill me-1"></i> Cập Nhật Mật Khẩu
        </button>
    </form>

    <div class="text-center pt-3 border-top">
        <a href="<c:url value='/login'/>" class="text-secondary small text-decoration-none">
            <i class="bi bi-arrow-left me-1"></i> Hủy bỏ và về Đăng nhập
        </a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function checkMatch() {
        const p1 = document.getElementById('newPassword').value;
        const p2 = document.getElementById('confirmPassword').value;
        const warn = document.getElementById('mismatch');
        if (p1 !== p2) {
            warn.classList.remove('d-none');
            return false;
        }
        warn.classList.add('d-none');
        return true;
    }
</script>
</body>
</html>