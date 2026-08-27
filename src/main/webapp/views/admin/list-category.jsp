<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách danh mục</title>
    <style>
        table {
            width: 80%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid black;
            padding: 8px;
        }
    </style>
</head>
<body>
    <h2>Quản lý danh mục</h2>
    <a href="${pageContext.request.contextPath}/admin/category/add">+ Thêm danh mục mới</a>
    <br><br>
    <table>
        <thead>
            <tr>
                <th>STT</th>
                <th>Hình ảnh</th>
                <th>Tên danh mục</th>
                <th>Hành động</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${cateList}" var="cate" varStatus="STT">
                <tr>
                    <td style="text-align: center;">${STT.index + 1}</td>
                    <td style="text-align: center;">
                        <c:if test="${not empty cate.icon}">
                            <img height="80" width="100" src="${pageContext.request.contextPath}/image?fname=${cate.icon}" alt="${cate.name}" />
                        </c:if>
                        <c:if test="${empty cate.icon}">
                            <span>Không có ảnh</span>
                        </c:if>
                    </td>
                    <td>${cate.name}</td>
                    <td style="text-align: center;">
                        <a href="${pageContext.request.contextPath}/admin/category/edit?id=${cate.id}">Sửa</a> | 
                        <a href="${pageContext.request.contextPath}/admin/category/delete?id=${cate.id}" onclick="return confirm('Bạn có chắc muốn xóa?');">Xóa</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>