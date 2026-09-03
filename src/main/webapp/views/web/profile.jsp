<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<head>
    <title>Hồ sơ cá nhân</title>
    <style>
        .profile-box { max-width: 500px; margin: 20px auto; border: 1px solid #ddd; padding: 25px; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; font-weight: bold; }
        .form-group input { width: 100%; padding: 8px; box-sizing: border-box; }
        .avatar-preview { width: 120px; height: 120px; border-radius: 50%; object-fit: cover; border: 2px solid #ccc; display: block; margin-bottom: 10px; }
        .btn-submit { background-color: #007bff; color: white; border: none; padding: 10px 15px; cursor: pointer; border-radius: 4px; }
        .alert-success { color: green; margin-bottom: 15px; font-weight: bold; }
    </style>
</head>

<body>
    <div class="profile-box">
        <h2>Cập nhật thông tin cá nhân</h2>

        <c:if test="${not empty message}">
            <div class="alert-success">${message}</div>
        </c:if>

        <form action="<c:url value='/profile'/>" method="post" enctype="multipart/form-data">
            <input type="hidden" name="id" value="${user.id}" />

            <div class="form-group">
                <label>Ảnh đại diện hiện tại:</label>
                <c:choose>
                    <c:when test="${not empty user.avatar}">
                        <img src="<c:url value='/image?fname=${user.avatar}'/>" alt="Avatar" class="avatar-preview" />
                    </c:when>
                    <c:otherwise>
                        <img src="https://via.placeholder.com/120" alt="Default Avatar" class="avatar-preview" />
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="form-group">
                <label for="image">Chọn ảnh đại diện mới:</label>
                <input type="file" id="image" name="image" accept="image/*" />
            </div>

            <div class="form-group">
                <label>Email (Không được sửa):</label>
                <input type="email" value="${user.email}" disabled />
            </div>

            <div class="form-group">
                <label for="fullname">Họ và tên:</label>
                <input type="text" id="fullname" name="fullname" value="${user.fullname}" required />
            </div>

            <div class="form-group">
                <label for="phone">Số điện thoại:</label>
                <input type="text" id="phone" name="phone" value="${user.phone}" />
            </div>

            <button type="submit" class="btn-submit">Lưu thông tin</button>
        </form>
    </div>
</body>