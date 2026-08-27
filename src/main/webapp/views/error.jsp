<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head><title>Lỗi</title></head>
<body>
    <h2 style="color: red;">Đăng nhập thất bại!</h2>
    <p>Sai tài khoản hoặc mật khẩu (Mặc định test: <b>admin / 123</b>).</p>
    <a href="${pageContext.request.contextPath}/login">Thử lại</a> | 
    <a href="${pageContext.request.contextPath}/home">Về trang chủ</a>
</body>
</html>