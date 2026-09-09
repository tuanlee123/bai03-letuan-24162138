<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Tiết Sản Phẩm #${p.productId} - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .sidebar { width: 250px; min-height: 100vh; background-color: #212529; }
        .sidebar .nav-link { color: #adb5bd; border-radius: 6px; margin-bottom: 4px; }
        .sidebar .nav-link:hover, .sidebar .nav-link.active { color: #fff; background-color: #343a40; }
        .main-wrapper { flex: 1; background-color: #f8f9fa; min-height: 100vh; }
        .prod-detail-img { max-height: 320px; max-width: 100%; object-fit: contain; }
    </style>
</head>
<body>
<div class="d-flex">
    <div class="sidebar p-3 d-flex flex-column text-white">
        <a href="<c:url value='/admin/home'/>" class="d-flex align-items-center mb-3 text-warning text-decoration-none fs-5 fw-bold">
            <i class="bi bi-shield-lock-fill me-2"></i> ADMIN PANEL
        </a>
        <hr class="text-secondary">
        <ul class="nav nav-pills flex-column mb-auto">
            <li><a href="<c:url value='/admin/home'/>" class="nav-link"><i class="bi bi-speedometer2 me-2"></i> Bảng điều khiển</a></li>
            <li><a href="<c:url value='/admin/categories'/>" class="nav-link"><i class="bi bi-folder2-open me-2"></i> Quản lý danh mục</a></li>
            <li><a href="<c:url value='/admin/products'/>" class="nav-link active"><i class="bi bi-box-seam me-2"></i> Quản lý sản phẩm</a></li>
            <li><a href="<c:url value='/home'/>" class="nav-link text-info"><i class="bi bi-globe me-2"></i> Xem ngoài Web</a></li>
        </ul>
        <hr class="text-secondary">
        <a href="<c:url value='/logout'/>" class="btn btn-outline-danger btn-sm w-100"><i class="bi bi-box-arrow-right me-1"></i> Đăng xuất</a>
    </div>

    <div class="main-wrapper p-4">
        <nav aria-label="breadcrumb" class="mb-4">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="<c:url value='/admin/home'/>" class="text-decoration-none">Bảng điều khiển</a></li>
                <li class="breadcrumb-item"><a href="<c:url value='/admin/products'/>" class="text-decoration-none">Quản lý sản phẩm</a></li>
                <li class="breadcrumb-item active">Chi tiết #${p.productId}</li>
            </ol>
        </nav>

        <div class="card border-0 shadow-sm">
            <div class="card-header bg-white py-3 border-bottom d-flex justify-content-between align-items-center">
                <h5 class="fw-bold text-dark mb-0"><i class="bi bi-info-circle text-primary me-2"></i>Chi Tiết Mặt Hàng</h5>
                <div>
                    <a href="<c:url value='/admin/product/edit?id=${p.productId}'/>" class="btn btn-warning btn-sm fw-semibold me-1">
                        <i class="bi bi-pencil-square me-1"></i> Sửa
                    </a>
                    <a href="<c:url value='/admin/products'/>" class="btn btn-outline-secondary btn-sm">Quay lại danh sách</a>
                </div>
            </div>
            <div class="card-body p-4">
                <div class="row g-4">
                    <div class="col-md-5 text-center p-3 bg-light rounded border d-flex align-items-center justify-content-center">
                        <c:choose>
                            <c:when test="${not empty p.imageUrl and p.imageUrl.startsWith('http')}">
                                <img src="${p.imageUrl}" alt="${p.productName}" class="prod-detail-img">
                            </c:when>
                            <c:when test="${not empty p.imageUrl}">
                                <img src="<c:url value='/image?fname=${p.imageUrl}'/>" alt="${p.productName}" class="prod-detail-img">
                            </c:when>
                            <c:otherwise>
                                <img src="https://via.placeholder.com/300?text=No+Image" alt="No Image" class="prod-detail-img">
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="col-md-7">
                        <span class="badge bg-light text-secondary border px-3 py-1 mb-2">
                            <i class="bi bi-folder me-1"></i> ${p.category.categoryname}
                        </span>
                        <h3 class="fw-bold text-dark mb-3">${p.productName}</h3>
                        
                        <div class="p-3 bg-light rounded-3 mb-3">
                            <span class="text-muted small d-block">Giá niêm yết:</span>
                            <span class="text-danger fw-bold fs-3">
                                <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                            </span>
                        </div>

                        <ul class="list-group list-group-flush mb-3">
                            <li class="list-group-item px-0 d-flex justify-content-between">
                                <span class="text-muted">Mã sản phẩm (ID):</span>
                                <span class="fw-bold">#${p.productId}</span>
                            </li>
                            <li class="list-group-item px-0 d-flex justify-content-between">
                                <span class="text-muted">Ngày tạo:</span>
                                <span><fmt:formatDate value="${p.createdAt}" pattern="dd/MM/yyyy HH:mm"/></span>
                            </li>
                        </ul>

                        <h6 class="fw-bold text-dark mt-3">Mô tả sản phẩm:</h6>
                        <div class="p-3 bg-white rounded border text-muted small" style="white-space: pre-line;">
                            ${p.description != null && !p.description.isEmpty() ? p.description : 'Chưa có thông tin mô tả chi tiết.'}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>