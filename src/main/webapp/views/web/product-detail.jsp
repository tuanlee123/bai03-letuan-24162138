<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head><title>Chi tiết sản phẩm</title></head>
<body style="font-family: Arial; padding: 20px;">
    <a href="javascript:history.back()" style="text-decoration: none;">🔙 Quay lại</a>
    <hr>
    <div style="display: flex; gap: 40px; margin-top: 20px;">
        <div>
            <img height="300" width="300" src="<c:url value='/image?fname=${p.imageUrl}'/>" style="border: 1px solid #eee; border-radius: 8px; object-fit: cover;" />
        </div>
        <div>
            <h2>${p.productName}</h2>
            <p><strong>Thuộc danh mục:</strong> ${p.category.categoryname}</p>
            <p><strong>Giá bán:</strong> <span style="color: red; font-size: 20px; font-weight: bold;">${p.price} VNĐ</span></p>
            <p><strong>Ngày đăng:</strong> ${p.createdAt}</p>
            <p><strong>Mô tả sản phẩm:</strong><br/> ${p.description}</p>
        </div>
    </div>
</body>
</html>