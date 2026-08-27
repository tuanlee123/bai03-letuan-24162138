<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chỉnh sửa danh mục</title>
</head>
<body>
    <h2>Chỉnh sửa danh mục</h2>
    <form action="${pageContext.request.contextPath}/admin/category/edit" method="post" enctype="multipart/form-data">
        <input type="hidden" name="id" value="${category.id}" />
        <div>
            <label>Tên danh mục:</label>
            <input type="text" name="name" value="${category.name}" required />
        </div>
        <br>
        <div>
            <label>Ảnh hiện tại:</label><br>
            <c:if test="${not empty category.icon}">
                <img width="100" src="${pageContext.request.contextPath}/image?fname=${category.icon}" /><br>
            </c:if>
            <label>Chọn ảnh mới (nếu muốn đổi):</label>
            <input type="file" name="icon" accept="image/*" />
        </div>
        <br>
        <button type="submit">Lưu thay đổi</button>
        <a href="${pageContext.request.contextPath}/admin/category/list">Hủy</a>
    </form>
</body>
</html>