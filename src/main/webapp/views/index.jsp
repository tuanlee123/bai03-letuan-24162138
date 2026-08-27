<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang chủ</title>
</head>
<body>
    <h2>Chào mừng bạn đến với trang chủ!</h2>
    <c:if test="${not empty sessionScope.account}">
        <p>Xin chào: <b>${sessionScope.account.username}</b> (${sessionScope.account.fullname})</p>
    </c:if>
    <c:if test="${empty sessionScope.account}">
        <a href="${pageContext.request.contextPath}/login">Đăng nhập</a>
    </c:if>
</body>
</html>