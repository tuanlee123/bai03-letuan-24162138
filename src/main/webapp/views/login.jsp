<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head><title>Đăng nhập</title></head>
<body>
    <h2>Đăng nhập hệ thống</h2>
    <p style="color:green">${param.msg == 'reset_success' ? 'Đổi mật khẩu thành công! Vui lòng đăng nhập lại.' : ''}</p>
    <p style="color:green">${param.msg == 'active_success' ? 'Kích hoạt tài khoản thành công!' : ''}</p>
    <p style="color:red">${error}</p>
    
    <form action="${pageContext.request.contextPath}/login" method="post">
        Email: <input type="email" name="email" required><br><br>
        Password: <input type="password" name="password" required><br><br>
        <button type="submit">Đăng nhập</button>
    </form>
    <br>
    <a href="${pageContext.request.contextPath}/register">Đăng ký ngay</a> | 
    <a href="${pageContext.request.contextPath}/forgot-password">Quên mật khẩu?</a>
</body>
</html>