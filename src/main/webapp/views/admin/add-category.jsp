<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm danh mục mới</title>
</head>
<body>
    <h2>Thêm danh mục mới</h2>
    <form action="${pageContext.request.contextPath}/admin/category/add" method="post" enctype="multipart/form-data">
        <div>
            <label>Tên danh mục:</label>
            <input type="text" name="name" required placeholder="Nhập tên danh mục..." />
        </div>
        <br>
        <div>
            <label>Ảnh đại diện:</label>
            <input type="file" name="icon" accept="image/*" />
        </div>
        <br>
        <button type="submit">Thêm mới</button>
        <a href="${pageContext.request.contextPath}/admin/category/list">Quay lại danh sách</a>
    </form>
</body>
</html>