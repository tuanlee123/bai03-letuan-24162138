<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm Sản Phẩm Mới - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .sidebar { width: 250px; min-height: 100vh; background-color: #212529; }
        .sidebar .nav-link { color: #adb5bd; border-radius: 6px; margin-bottom: 4px; }
        .sidebar .nav-link:hover, .sidebar .nav-link.active { color: #fff; background-color: #343a40; }
        .main-wrapper { flex: 1; background-color: #f8f9fa; min-height: 100vh; }
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
                <li class="breadcrumb-item active">Thêm mới</li>
            </ol>
        </nav>

        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card border-0 shadow-sm">
                    <div class="card-header bg-white py-3 border-bottom">
                        <h5 class="mb-0 fw-bold text-success"><i class="bi bi-plus-circle me-2"></i>Thêm Mới Sản Phẩm</h5>
                    </div>
                    <div class="card-body p-4">
                        <form action="<c:url value='/admin/product/insert'/>" method="post" enctype="multipart/form-data">
                            <div class="mb-3">
                                <label for="productName" class="form-label fw-semibold">Tên sản phẩm <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="productName" name="productName" placeholder="Ví dụ: iPhone 15 Pro Max, Dell XPS 13..." required>
                            </div>

                            <div class="mb-3">
                                <label for="categoryId" class="form-label fw-semibold">Danh mục <span class="text-danger">*</span></label>
                                <select class="form-select" id="categoryId" name="categoryId" required>
                                    <option value="" disabled selected>-- Chọn danh mục mặt hàng --</option>
                                    <c:forEach items="${listcate}" var="c">
                                        <option value="${c.categoryId}">${c.categoryname}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label for="price" class="form-label fw-semibold">Giá bán (VNĐ) <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <span class="input-group-text">₫</span>
                                    <input type="number" class="form-control" id="price" name="price" min="1000" step="500" placeholder="15000000" required>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="image" class="form-label fw-semibold">Hình ảnh sản phẩm <span class="text-danger">*</span></label>
                                <input type="file" class="form-control" id="image" name="image" accept="image/*" required onchange="previewImg(this)">
                                <div class="mt-3 text-center d-none" id="wrapPreview">
                                    <img id="previewImgTag" src="#" alt="Preview" class="rounded border p-1" style="max-height: 140px; object-fit: cover;">
                                </div>
                            </div>

                            <div class="mb-4">
                                <label for="description" class="form-label fw-semibold">Mô tả sản phẩm</label>
                                <textarea class="form-control" id="description" name="description" rows="4" placeholder="Thông số kỹ thuật, bảo hành..."></textarea>
                            </div>

                            <div class="d-flex gap-2">
                                <button type="submit" class="btn btn-success px-4 fw-semibold">
                                    <i class="bi bi-save me-1"></i> Lưu Sản Phẩm
                                </button>
                                <a href="<c:url value='/admin/products'/>" class="btn btn-secondary px-3">Quay lại</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    function previewImg(input) {
        if (input.files && input.files[0]) {
            const reader = new FileReader();
            reader.onload = e => {
                document.getElementById('previewImgTag').src = e.target.result;
                document.getElementById('wrapPreview').classList.remove('d-none');
            };
            reader.readAsDataURL(input.files[0]);
        }
    }
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>