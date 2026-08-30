<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head><title>Xác thực OTP</title></head>
<body>
    <h2>Nhập mã OTP đã được gửi về Email của bạn</h2>
    <p style="color:red">${error}</p>
    <form action="${pageContext.request.contextPath}/verify-otp" method="post">
        Nhập OTP: <input type="text" name="otp" required><br><br>
        <button type="submit">Xác nhận</button>
    </form>
</body>
</html>