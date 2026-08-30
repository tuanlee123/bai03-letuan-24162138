<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý Sản phẩm - Admin</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        table { width: 100%; border-collapse: collapse; margin-top: 15px; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: left; }
        th { background-color: #f2f2f2; }
        img { width: 70px; height: 70px; object-fit: cover; border-radius: 4px; }
        .btn { padding: 6px 12px; text-decoration: none; border-radius: 4px; color: white; display: inline-block; }
        .btn-add { background-color: #28a745; margin-bottom: 10px; }
        .btn-edit { background-color: #ffc107; color: black; }
        .btn-delete { background-color: #dc3545; }
    </style>
</head>
<body>

    <h2>DANH SÁCH QUẢN LÝ SẢN PHẨM</h2>
    
    <a href="<c:url value='/admin/product/add'/>" class="btn btn-add">+ Thêm Sản Phẩm Mới</a>
    <a href="<c:url value='/home'/>" style="margin-left: 15px;">⬅ Quay về Trang chủ</a>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Hình ảnh</th>
                <th>Tên sản phẩm</th>
                <th>Giá</th>
                <th>Danh mục</th>
                <th>Hành động</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${listprod}" var="p">
                <tr>
                    <td>${p.productId}</td>
                    <td>
                        <c:choose>
                            <c:when test="${p.imageUrl.startsWith('http')}">
                                <img src="${p.imageUrl}" alt="${p.productName}" />
                            </c:when>
                            <c:otherwise>
                                <img src="<c:url value='/image?fname=${p.imageUrl}'/>" alt="${p.productName}" />
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td><b>${p.productName}</b></td>
                    <td>${p.price} VNĐ</td>
                    <td>${p.category.categoryName}</td>
                    <td>
                        <a href="<c:url value='/admin/product/edit?id=${p.productId}'/>" class="btn btn-edit">Sửa</a>
                        <a href="<c:url value='/admin/product/delete?id=${p.productId}'/>" class="btn btn-delete" onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này không?')">Xóa</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

</body>
</html>