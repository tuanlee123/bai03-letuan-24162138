<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Ký Tài Khoản - SHOPPING ONLINE</title>
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
            padding: 24px 0;
        }
        .auth-card {
            border: none;
            border-radius: 16px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.06);
            width: 100%;
            max-width: 480px;
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
        <p class="text-muted small mb-0">Tạo tài khoản mới để trải nghiệm mua sắm</p>
    </div>

    <!-- Thông báo lỗi nếu có -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show small py-2" role="alert">
            <i class="bi bi-exclamation-triangle-fill me-1"></i> ${error}
            <button type="button" class="btn-close py-2" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <form action="<c:url value='/register'/>" method="post" onsubmit="return validateForm()">
        <!-- Tên đăng nhập -->
        <div class="mb-3">
            <label for="username" class="form-label small fw-semibold text-secondary">Tên đăng nhập <span class="text-danger">*</span></label>
            <div class="input-group">
                <span class="input-group-text"><i class="bi bi-person text-muted"></i></span>
                <input type="text" class="form-control" id="username" name="username" value="${username}" placeholder="Ví dụ: user123" required autofocus>
            </div>
        </div>

        <!-- Họ và tên -->
        <div class="mb-3">
            <label for="fullname" class="form-label small fw-semibold text-secondary">Họ và tên <span class="text-danger">*</span></label>
            <div class="input-group">
                <span class="input-group-text"><i class="bi bi-card-text text-muted"></i></span>
                <input type="text" class="form-control" id="fullname" name="fullname" value="${fullname}" placeholder="Ví dụ: Nguyễn Văn A" required>
            </div>
        </div>

        <!-- Email -->
        <div class="mb-3">
            <label for="email" class="form-label small fw-semibold text-secondary">Địa chỉ Email <span class="text-danger">*</span></label>
            <div class="input-group">
                <span class="input-group-text"><i class="bi bi-envelope text-muted"></i></span>
                <input type="email" class="form-control" id="email" name="email" value="${email}" placeholder="example@gmail.com" required>
            </div>
        </div>

        <!-- Số điện thoại -->
        <div class="mb-3">
            <label for="phone" class="form-label small fw-semibold text-secondary">Số điện thoại</label>
            <div class="input-group">
                <span class="input-group-text"><i class="bi bi-telephone text-muted"></i></span>
                <input type="tel" class="form-control" id="phone" name="phone" value="${phone}" placeholder="0901234567">
            </div>
        </div>

        <!-- Mật khẩu -->
        <div class="mb-3">
            <label for="password" class="form-label small fw-semibold text-secondary">Mật khẩu <span class="text-danger">*</span></label>
            <div class="input-group">
                <span class="input-group-text"><i class="bi bi-lock text-muted"></i></span>
                <input type="password" class="form-control" id="password" name="password" placeholder="Tối thiểu 6 ký tự" required minlength="6">
                <button class="btn btn-outline-secondary" type="button" onclick="togglePassword('password', 'eyeReg1')">
                    <i class="bi bi-eye" id="eyeReg1"></i>
                </button>
            </div>
        </div>

        <!-- Nhập lại mật khẩu -->
        <div class="mb-3">
            <label for="confirmPassword" class="form-label small fw-semibold text-secondary">Xác nhận mật khẩu <span class="text-danger">*</span></label>
            <div class="input-group">
                <span class="input-group-text"><i class="bi bi-shield-lock text-muted"></i></span>
                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Nhập lại mật khẩu" required minlength="6">
                <button class="btn btn-outline-secondary" type="button" onclick="togglePassword('confirmPassword', 'eyeReg2')">
                    <i class="bi bi-eye" id="eyeReg2"></i>
                </button>
            </div>
            <div id="pwdMismatch" class="text-danger small mt-1 d-none">Mật khẩu nhập lại không khớp!</div>
        </div>

        <!-- Điều khoản -->
        <div class="mb-4 form-check">
            <input type="checkbox" class="form-check-input" id="terms" required>
            <label class="form-check-label small text-muted" for="terms">
                Tôi đồng ý với các <a href="#" class="text-decoration-none">Điều khoản sử dụng</a> và Chính sách bảo mật
            </label>
        </div>

        <!-- Nút Đăng ký -->
        <button type="submit" class="btn btn-warning w-100 py-2 fw-bold text-dark shadow-sm mb-3">
            <i class="bi bi-person-plus-fill me-1"></i> Hoàn Tất Đăng Ký
        </button>

        <div class="text-center">
            <span class="small text-muted">Đã có tài khoản? </span>
            <a href="<c:url value='/login'/>" class="small fw-semibold text-decoration-none">Đăng nhập ngay</a>
        </div>
    </form>

    <div class="text-center mt-4 pt-3 border-top">
        <a href="<c:url value='/home'/>" class="text-secondary small text-decoration-none">
            <i class="bi bi-arrow-left me-1"></i> Quay về trang chủ
        </a>
    </div>
</div>

<!-- Script kiểm tra mật khẩu trùng khớp & Bootstrap Bundle -->
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

    function validateForm() {
        const pwd = document.getElementById('password').value;
        const confirmPwd = document.getElementById('confirmPassword').value;
        const mismatchDiv = document.getElementById('pwdMismatch');

        if (pwd !== confirmPwd) {
            mismatchDiv.classList.remove('d-none');
            return false;
        }
        mismatchDiv.classList.add('d-none');
        return true;
    }
</script>
</body>
</html>