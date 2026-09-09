<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cập Nhật Sản Phẩm #${p.productId} - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .sidebar { width: 250px; min-height: 100vh; background-color: #212529; }
        .sidebar .nav-link { color: #adb5bd; border-radius: 6px; margin-bottom: 4px; }
        .sidebar .nav-link:hover, .sidebar .nav-link.active { color: #fff; background-color: #343a40; }
        .main-wrapper { flex: 1; background-color: #f8f9fa; min-height: 100vh; }
        .current-img-preview { max-height: 140px; max-width: 100%; object-fit: contain; }
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
                <li class="breadcrumb-item active">Cập nhật #${p.productId}</li>
            </ol>
        </nav>

        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card border-0 shadow-sm">
                    <div class="card-header bg-white py-3 border-bottom d-flex justify-content-between align-items-center">
                        <h5 class="mb-0 fw-bold text-dark">
                            <i class="bi bi-pencil-square me-2 text-warning"></i>Cập Nhật Thông Tin Sản Phẩm
                        </h5>
                        <span class="badge bg-secondary">Mã SP: #${p.productId}</span>
                    </div>

                    <div class="card-body p-4">
                        <form action="<c:url value='/admin/product/edit'/>" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="productId" value="${p.productId}">
                            <input type="hidden" name="oldImage" value="${p.imageUrl}">

                            <div class="mb-3">
                                <label for="productName" class="form-label fw-semibold">Tên sản phẩm <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="productName" name="productName" value="${p.productName}" required>
                            </div>

                            <div class="mb-3">
                                <label for="categoryId" class="form-label fw-semibold">Danh mục mặt hàng <span class="text-danger">*</span></label>
                                <select class="form-select" id="categoryId" name="categoryId" required>
                                    <c:forEach items="${listCate}" var="c">
                                        <option value="${c.categoryId}" ${p.category.categoryId == c.categoryId ? 'selected' : ''}>
                                            ${c.categoryname}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label for="price" class="form-label fw-semibold">Giá bán (VNĐ) <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <span class="input-group-text">₫</span>
                                    <input type="number" class="form-control" id="price" name="price" value="${p.price}" min="1000" step="500" required>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-semibold">Hình ảnh sản phẩm</label>
                                <div class="p-3 bg-light rounded border mb-2 text-center">
                                    <small class="text-muted d-block mb-2">Ảnh hiện tại:</small>
                                    <c:choose>
                                        <c:when test="${not empty p.imageUrl and p.imageUrl.startsWith('http')}">
                                            <img id="currentImageTag" src="${p.imageUrl}" alt="${p.productName}" class="current-img-preview rounded border shadow-sm">
                                        </c:when>
                                        <c:when test="${not empty p.imageUrl}">
                                            <img id="currentImageTag" src="<c:url value='/image?fname=${p.imageUrl}'/>" alt="${p.productName}" class="current-img-preview rounded border shadow-sm">
                                        </c:when>
                                        <c:otherwise>
                                            <img id="currentImageTag" src="https://via.placeholder.com/120?text=No+Image" alt="No Image" class="current-img-preview rounded border shadow-sm">
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <input type="file" class="form-control" id="image" name="image" accept="image/*" onchange="previewNewImg(this)">
                                <small class="text-muted">Chọn file mới nếu bạn muốn thay đổi ảnh đại diện.</small>
                                
                                <div class="mt-3 text-center d-none" id="wrapNewPreview">
                                    <small class="text-success fw-semibold d-block mb-1">Xem trước ảnh mới:</small>
                                    <img id="previewNewImgTag" src="#" alt="New Preview" class="current-img-preview rounded border border-success p-1">
                                </div>
                            </div>

                            <div class="mb-4">
                                <label for="description" class="form-label fw-semibold">Mô tả sản phẩm</label>
                                <textarea class="form-control" id="description" name="description" rows="4">${p.description}</textarea>
                            </div>

                            <div class="d-flex gap-2">
                                <button type="submit" class="btn btn-warning px-4 fw-bold text-dark shadow-sm">
                                    <i class="bi bi-check2-circle me-1"></i> Lưu Cập Nhật
                                </button>
                                <a href="<c:url value='/admin/products'/>" class="btn btn-secondary px-3">
                                    <i class="bi bi-x-circle me-1"></i> Hủy Bỏ
                                </a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function previewNewImg(input) {
        if (input.files && input.files[0]) {
            const reader = new FileReader();
            reader.onload = e => {
                document.getElementById('previewNewImgTag').src = e.target.result;
                document.getElementById('wrapNewPreview').classList.remove('d-none');
            };
            reader.readAsDataURL(input.files[0]);
        }
    }
</script>
</body>
</html>