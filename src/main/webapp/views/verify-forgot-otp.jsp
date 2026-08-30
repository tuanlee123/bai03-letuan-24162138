<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head><title>Xác nhận OTP</title></head>
<body>
    <h2>Xác nhận OTP Đổi mật khẩu</h2>
    <p style="color:red">${error}</p>
    <form action="${pageContext.request.contextPath}/verify-forgot-otp" method="post">
        Mã OTP: <input type="text" name="otp" required><br><br>
        <button type="submit">Xác nhận</button>
    </form>
</body>
</html>