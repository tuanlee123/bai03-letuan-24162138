<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Sản Phẩm - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .sidebar { width: 250px; min-height: 100vh; background-color: #212529; }
        .sidebar .nav-link { color: #adb5bd; border-radius: 6px; margin-bottom: 4px; }
        .sidebar .nav-link:hover, .sidebar .nav-link.active { color: #fff; background-color: #343a40; }
        .main-wrapper { flex: 1; background-color: #f8f9fa; min-height: 100vh; }
        .product-img { width: 55px; height: 55px; object-fit: cover; border-radius: 8px; }
        .table > tbody > tr > td { vertical-align: middle; }
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
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h3 class="fw-bold text-dark mb-0">Quản Lý Sản Phẩm</h3>
                <small class="text-muted">Danh sách tất cả các mặt hàng công nghệ đang bán trong kho</small>
            </div>
            <a href="<c:url value='/admin/product/add'/>" class="btn btn-success fw-semibold shadow-sm px-3">
                <i class="bi bi-plus-circle me-1"></i> Thêm Mới Sản Phẩm
            </a>
        </div>

        <div class="card border-0 shadow-sm mb-4">
            <div class="card-body p-3">
                <form action="<c:url value='/admin/products'/>" method="get" class="row g-2 align-items-center">
                    <div class="col-md-5">
                        <div class="input-group">
                            <span class="input-group-text bg-white text-muted"><i class="bi bi-search"></i></span>
                            <input type="text" name="keyword" value="${param.keyword}" class="form-control border-start-0" placeholder="Tìm theo tên sản phẩm...">
                        </div>
                    </div>
                    <div class="col-md-4">
                        <select name="categoryId" class="form-select">
                            <option value="">-- Tất cả danh mục --</option>
                            <c:forEach items="${listcate}" var="c">
                                <option value="${c.categoryId}" ${param.categoryId == c.categoryId ? 'selected' : ''}>
                                    ${c.categoryname}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-3 d-flex gap-2">
                        <button type="submit" class="btn btn-primary w-100 fw-semibold">
                            <i class="bi bi-funnel me-1"></i> Lọc dữ liệu
                        </button>
                        <a href="<c:url value='/admin/products'/>" class="btn btn-outline-secondary" title="Đặt lại">
                            <i class="bi bi-arrow-counterclockwise"></i>
                        </a>
                    </div>
                </form>
            </div>
        </div>

        <div class="card shadow-sm border-0">
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover table-striped align-middle mb-0">
                        <thead class="table-dark">
                            <tr>
                                <th class="text-center" style="width: 70px;">#ID</th>
                                <th style="width: 90px;">Hình ảnh</th>
                                <th>Tên sản phẩm</th>
                                <th style="width: 150px;">Danh mục</th>
                                <th style="width: 150px;">Giá bán</th>
                                <th>Mô tả tóm tắt</th>
                                <th class="text-center" style="width: 160px;">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty listprod}">
                                    <c:forEach items="${listprod}" var="prod">
                                        <tr>
                                            <td class="text-center fw-bold text-secondary">#${prod.productId}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${prod.imageUrl.startsWith('http')}">
                                                        <img src="${prod.imageUrl}" alt="${prod.productName}" class="product-img border shadow-sm">
                                                    </c:when>
                                                    <c:when test="${not empty prod.imageUrl}">
                                                        <img src="<c:url value='/image?fname=${prod.imageUrl}'/>" alt="${prod.productName}" class="product-img border shadow-sm">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img src="https://via.placeholder.com/55?text=No+Img" alt="No Image" class="product-img border shadow-sm">
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <a href="<c:url value='/admin/product/detail?id=${prod.productId}'/>" class="fw-semibold text-dark text-decoration-none">
                                                    ${prod.productName}
                                                </a>
                                            </td>
                                            <td>
                                                <span class="badge bg-light text-secondary border px-2 py-1">
                                                    <i class="bi bi-tag me-1"></i>${prod.category.categoryname}
                                                </span>
                                            </td>
                                            <td>
                                                <span class="text-danger fw-bold">
                                                    <fmt:formatNumber value="${prod.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                                </span>
                                            </td>
                                            <td>
                                                <span class="text-muted small text-truncate d-inline-block" style="max-width: 250px;" title="${prod.description}">
                                                    ${prod.description != null && !prod.description.isEmpty() ? prod.description : 'Chưa có mô tả'}
                                                </span>
                                            </td>
                                            <td class="text-center">
                                                <div class="btn-group btn-group-sm">
                                                    <a href="<c:url value='/admin/product/detail?id=${prod.productId}'/>" class="btn btn-outline-info" title="Xem chi tiết">
                                                        <i class="bi bi-eye"></i>
                                                    </a>
                                                    <a href="<c:url value='/admin/product/edit?id=${prod.productId}'/>" class="btn btn-outline-warning" title="Sửa sản phẩm">
                                                        <i class="bi bi-pencil-square"></i>
                                                    </a>
                                                    <button type="button" class="btn btn-outline-danger" onclick="confirmDelete('${prod.productId}', '${prod.productName}')" title="Xóa">
                                                        <i class="bi bi-trash"></i>
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="7" class="text-center py-5 text-muted">
                                            <i class="bi bi-inbox fs-1 d-block mb-2 opacity-50"></i>
                                            Không tìm thấy sản phẩm nào trong kho hàng.
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Modal xác nhận xóa Bootstrap 5 -->
<div class="modal fade" id="deleteModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title text-danger fw-bold"><i class="bi bi-exclamation-triangle-fill me-2"></i>Xác nhận xóa</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                Bạn có chắc chắn muốn xóa sản phẩm <strong id="deleteProdName" class="text-dark"></strong> (ID: <span id="deleteProdId" class="text-secondary"></span>)?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Hủy bỏ</button>
                <a id="btnConfirmDelete" href="#" class="btn btn-danger btn-sm fw-semibold">Xóa vĩnh viễn</a>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const deleteModal = new bootstrap.Modal(document.getElementById('deleteModal'));
    function confirmDelete(id, name) {
        document.getElementById('deleteProdId').innerText = '#' + id;
        document.getElementById('deleteProdName').innerText = name;
        document.getElementById('btnConfirmDelete').href = '<c:url value="/admin/product/delete?id="/>' + id;
        deleteModal.show();
    }
</script>
</body>
</html>