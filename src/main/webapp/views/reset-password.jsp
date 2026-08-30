<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head><title>Đặt lại mật khẩu</title></head>
<body>
    <h2>Đặt lại mật khẩu mới</h2>
    <form action="${pageContext.request.contextPath}/reset-password" method="post">
        Mật khẩu mới: <input type="password" name="newPassword" required><br><br>
        <button type="submit">Cập nhật mật khẩu</button>
    </form>
</body>
</html>