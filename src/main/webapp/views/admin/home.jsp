<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang Quản Trị Admin</title>
</head>
<body>
    <h2>Chào mừng Admin đến với trang quản trị!</h2>
    <c:if test="${not empty sessionScope.account}">
        <p>Xin chào: <b>${sessionScope.account.fullname}</b> (Username: ${sessionScope.account.username})</p>
        <p>Email: ${sessionScope.account.email}</p>
        <p>Vai trò: Admin (Role ID: ${sessionScope.account.roleid})</p>
    </c:if>
    <br>
    <a href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
</body>
</html>