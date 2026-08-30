<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head><title>Trang Chủ - Top 10 Mới Nhất</title></head>
<body style="font-family: Arial; padding: 20px;">
    <h2>10 Sản phẩm mới nhất</h2>
    <a href="<c:url value='/product'/>">👉 Xem tất cả sản phẩm (Phân trang)</a>
    <hr>
    <div style="display: flex; flex-wrap: wrap; gap: 20px;">
        <c:forEach items="${top10}" var="p">
            <div style="border: 1px solid #ccc; padding: 10px; width: 200px; text-align: center; border-radius: 8px;">
                <img height="150" width="150" src="<c:url value='/image?fname=${p.imageUrl}'/>" style="object-fit: cover;" />
                <h3 style="font-size: 16px;">${p.productName}</h3>
                <p style="color: red; font-weight: bold;">${p.price} VNĐ</p>
                <a href="<c:url value='/product/detail?id=${p.productId}'/>" style="text-decoration: none; color: blue;">Xem chi tiết</a>
            </div>
        </c:forEach>
    </div>
</body>
</html>