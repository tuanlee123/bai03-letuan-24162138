<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang Chủ Người Dùng</title>
</head>
<body>
    <h2>Chào mừng bạn đến với trang chủ!</h2>
    <c:if test="${not empty sessionScope.account}">
        <p>Xin chào: <b>${sessionScope.account.fullname}</b> (Username: ${sessionScope.account.username})</p>
        <p>Email: ${sessionScope.account.email}</p>
        <p>Số điện thoại: ${sessionScope.account.phone}</p>
        <p>Vai trò: User thường (Role ID: ${sessionScope.account.roleid})</p>
    </c:if>
    <br>
    <a href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
</body>
</html>