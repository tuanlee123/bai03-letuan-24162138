<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cập Nhật Danh Mục #${cate.categoryId} - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .sidebar { width: 250px; min-height: 100vh; background-color: #212529; }
        .sidebar .nav-link { color: #adb5bd; border-radius: 6px; margin-bottom: 4px; }
        .sidebar .nav-link:hover, .sidebar .nav-link.active { color: #fff; background-color: #343a40; }
        .main-wrapper { flex: 1; background-color: #f8f9fa; min-height: 100vh; }
        .preview-img { max-height: 120px; object-fit: contain; }
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
            <li><a href="<c:url value='/admin/categories'/>" class="nav-link active"><i class="bi bi-folder2-open me-2"></i> Quản lý danh mục</a></li>
            <li><a href="<c:url value='/admin/products'/>" class="nav-link"><i class="bi bi-box-seam me-2"></i> Quản lý sản phẩm</a></li>
            <li><a href="<c:url value='/home'/>" class="nav-link text-info"><i class="bi bi-globe me-2"></i> Xem ngoài Web</a></li>
        </ul>
        <hr class="text-secondary">
        <a href="<c:url value='/logout'/>" class="btn btn-outline-danger btn-sm w-100"><i class="bi bi-box-arrow-right me-1"></i> Đăng xuất</a>
    </div>

    <div class="main-wrapper p-4">
        <nav aria-label="breadcrumb" class="mb-4">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="<c:url value='/admin/home'/>" class="text-decoration-none">Bảng điều khiển</a></li>
                <li class="breadcrumb-item"><a href="<c:url value='/admin/categories'/>" class="text-decoration-none">Quản lý danh mục</a></li>
                <li class="breadcrumb-item active">Cập nhật #${cate.categoryId}</li>
            </ol>
        </nav>

        <div class="row justify-content-center">
            <div class="col-lg-7">
                <div class="card border-0 shadow-sm">
                    <div class="card-header bg-white py-3 border-bottom d-flex justify-content-between align-items-center">
                        <h5 class="fw-bold text-dark mb-0"><i class="bi bi-pencil-square text-warning me-2"></i>Cập Nhật Danh Mục</h5>
                        <span class="badge bg-secondary">Mã: #${cate.categoryId}</span>
                    </div>
                    <div class="card-body p-4">
                        <form action="<c:url value='/admin/category/edit'/>" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="categoryId" value="${cate.categoryId}">
                            <input type="hidden" name="oldImage" value="${cate.images}">

                            <div class="mb-3">
                                <label for="categoryname" class="form-label fw-semibold">Tên danh mục <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="categoryname" name="categoryname" value="${cate.categoryname}" required>
                            </div>

                            <div class="mb-3">
                                <label for="status" class="form-label fw-semibold">Trạng thái</label>
                                <select class="form-select" id="status" name="status">
                                    <option value="1" ${cate.status == 1 ? 'selected' : ''}>Hoạt động (Hiển thị ngoài web)</option>
                                    <option value="0" ${cate.status == 0 ? 'selected' : ''}>Khóa (Tạm ẩn)</option>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-semibold">Hình ảnh đại diện</label>
                                <div class="p-3 bg-light rounded border text-center mb-2">
                                    <small class="text-muted d-block mb-1">Ảnh hiện tại:</small>
                                    <c:choose>
                                        <c:when test="${not empty cate.images and cate.images.startsWith('http')}">
                                            <img src="${cate.images}" alt="${cate.categoryname}" class="preview-img rounded border">
                                        </c:when>
                                        <c:when test="${not empty cate.images}">
                                            <img src="<c:url value='/image?fname=${cate.images}'/>" alt="${cate.categoryname}" class="preview-img rounded border">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="https://via.placeholder.com/80?text=No+Img" alt="No Img" class="preview-img rounded border">
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <input type="file" class="form-control" id="image" name="image" accept="image/*" onchange="previewImg(this)">
                                <small class="text-muted">Chọn file mới nếu muốn thay đổi ảnh.</small>

                                <div class="mt-3 text-center d-none" id="wrapPreview">
                                    <small class="text-success fw-semibold d-block mb-1">Ảnh mới thay thế:</small>
                                    <img id="previewImgTag" src="#" alt="Preview" class="preview-img rounded border border-success p-1">
                                </div>
                            </div>

                            <div class="d-flex gap-2 mt-4">
                                <button type="submit" class="btn btn-warning px-4 fw-bold text-dark shadow-sm">
                                    <i class="bi bi-check2-circle me-1"></i> Lưu Thay Đổi
                                </button>
                                <a href="<c:url value='/admin/categories'/>" class="btn btn-outline-secondary px-3">Quay lại</a>
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