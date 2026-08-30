<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head><title>Quên mật khẩu</title></head>
<body>
    <h2>Quên mật khẩu</h2>
    <p>Vui lòng nhập Email đã đăng ký, chúng tôi sẽ gửi mã OTP xác nhận cho bạn.</p>
    <p style="color:red">${error}</p>
    <form action="${pageContext.request.contextPath}/forgot-password" method="post">
        Email: <input type="email" name="email" required><br><br>
        <button type="submit">Gửi mã OTP</button>
    </form>
</body>
</html>