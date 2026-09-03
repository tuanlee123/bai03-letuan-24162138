<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang Chủ - Top 10 Mới Nhất</title>
</head>
<body>

    <h2 style="border-bottom: 2px solid #007bff; padding-bottom: 10px;">10 Sản phẩm mới nhất</h2>
    
    <!-- Danh sách sản phẩm Top 10 -->
    <div style="display: flex; flex-wrap: wrap; gap: 20px; margin-top: 20px;">
        <c:forEach items="${top10}" var="p">
            <div style="border: 1px solid #ddd; padding: 15px; border-radius: 8px; width: 220px; text-align: center; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
                <!-- Hiển thị ảnh qua ImageController -->
                <img src="<c:url value='/image?fname=${p.imageUrl}'/>" alt="${p.productName}" style="width: 100%; height: 160px; object-fit: cover; border-radius: 4px;">
                
                <h3 style="font-size: 16px; margin: 15px 0 10px 0;">${p.productName}</h3>
                <p style="color: red; font-weight: bold; font-size: 18px;">${p.price} VNĐ</p>
                
                <a href="<c:url value='/product/detail?id=${p.productId}'/>" style="display: block; margin-top: 15px; padding: 8px; background: #007bff; color: white; text-decoration: none; border-radius: 4px;">Xem chi tiết</a>
            </div>
        </c:forEach>
    </div>
    
    <div style="margin-top: 30px; text-align: center;">
        <a href="${pageContext.request.contextPath}/product" style="font-size: 18px; font-weight: bold; text-decoration: none; color: #28a745;">👉 Xem tất cả sản phẩm (Phân trang)</a>
    </div>

</body>
</html>