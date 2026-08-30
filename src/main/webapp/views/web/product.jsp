<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head><title>Tất cả sản phẩm</title></head>
<body style="font-family: Arial; padding: 20px;">
    <h2>Danh sách tất cả sản phẩm</h2>
    <a href="<c:url value='/home'/>">🏠 Về Trang chủ</a>
    <hr>
    
    <div style="display: flex; flex-wrap: wrap; gap: 20px;">
        <c:forEach items="${listprod}" var="p">
            <div style="border: 1px solid #ccc; padding: 10px; width: 200px; text-align: center; border-radius: 8px;">
                <img height="150" width="150" src="<c:url value='/image?fname=${p.imageUrl}'/>" style="object-fit: cover;" />
                <h3 style="font-size: 16px;">${p.productName}</h3>
                <p style="color: red; font-weight: bold;">${p.price} VNĐ</p>
                <a href="<c:url value='/product/detail?id=${p.productId}'/>" style="text-decoration: none; color: blue;">Xem chi tiết</a>
            </div>
        </c:forEach>
    </div>

    <!-- Khối hiển thị số trang -->
    <div style="margin-top: 30px;">
        <strong>Trang: </strong>
        <c:forEach begin="1" end="${endPage}" var="i">
            <a href="<c:url value='/product?page=${i}'/>" 
               style="padding: 5px 10px; margin: 0 5px; border: 1px solid #000; text-decoration: none; border-radius: 4px;
                      background-color: ${tag == i ? '#007bff' : 'white'}; 
                      color: ${tag == i ? 'white' : 'black'};">
               ${i}
            </a>
        </c:forEach>
    </div>
</body>
</html>