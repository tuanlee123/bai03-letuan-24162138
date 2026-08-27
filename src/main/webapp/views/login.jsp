<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập hệ thống</title>
</head>
<body>
    <h2>Đăng Nhập Vào Hệ Thống</h2>
    
    <c:if test="${not empty alert}">
        <p style="color: red;">${alert}</p>
    </c:if>

    <form action="${pageContext.request.contextPath}/login" method="post">
        <div>
            <label>Tài khoản:</label>
            <input type="text" name="username" required />
        </div>
        <br>
        <div>
            <label>Mật khẩu:</label>
            <input type="password" name="password" required />
        </div>
        <br>
        <div>
            <label><input type="checkbox" name="remember"> Nhớ tôi (Remember me)</label>
        </div>
        <br>
        <button type="submit">Đăng nhập</button>
    </form>
</body>
</html>