<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${product != null ? product.productName : 'Chi Tiết Sản Phẩm'} - SHOPPING ONLINE</title>
    <!-- Bootstrap 5 CSS & Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .product-main-img {
            max-height: 420px;
            width: 100%;
            object-fit: contain;
            transition: transform 0.3s ease;
        }
        .img-container {
            background-color: #fff;
            border-radius: 16px;
            min-height: 420px;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 24px;
        }
        .price-tag {
            font-size: 2rem;
            color: #dc3545;
            font-weight: 700;
        }
        .policy-card {
            border: 1px dashed #dee2e6;
            border-radius: 12px;
            background-color: #fff;
        }
        .quantity-btn {
            width: 38px;
            height: 38px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .product-rel-card:hover {
            transform: translateY(-4px);
            transition: transform 0.2s ease;
        }
    </style>
</head>
<body class="bg-light d-flex flex-column min-vh-100">

    <!-- Navbar Khách Hàng -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top shadow-sm">
        <div class="container">
            <a class="navbar-brand fw-bold text-warning" href="<c:url value='/home'/>">
                <i class="bi bi-cart3 me-2"></i>SHOPPING ONLINE
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mainNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="mainNav">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value='/home'/>"><i class="bi bi-house-door me-1"></i>Trang chủ</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active fw-semibold" href="<c:url value='/product'/>"><i class="bi bi-grid me-1"></i>Sản phẩm</a>
                    </li>
                </ul>
                <ul class="navbar-nav ms-auto align-items-center">
                    <c:choose>
                        <c:when test="${not empty sessionScope.account}">
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle text-white fw-semibold" href="#" role="button" data-bs-toggle="dropdown">
                                    <i class="bi bi-person-circle me-1"></i> ${sessionScope.account.username}
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end shadow">
                                    <c:if test="${sessionScope.account.roleid == 1 or sessionScope.account.role == 'admin'}">
                                        <li><a class="dropdown-item" href="<c:url value='/admin/home'/>"><i class="bi bi-speedometer2 me-2"></i>Trang Quản Trị</a></li>
                                        <li><hr class="dropdown-divider"></li>
                                    </c:if>
                                    <li><a class="dropdown-item" href="<c:url value='/profile'/>"><i class="bi bi-person me-2"></i>Hồ sơ cá nhân</a></li>
                                    <li><a class="dropdown-item text-danger" href="<c:url value='/logout'/>"><i class="bi bi-box-arrow-right me-2"></i>Đăng xuất</a></li>
                                </ul>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item">
                                <a class="btn btn-outline-light btn-sm me-2 px-3" href="<c:url value='/login'/>">Đăng nhập</a>
                            </li>
                            <li class="nav-item">
                                <a class="btn btn-warning btn-sm px-3 fw-semibold" href="<c:url value='/register'/>">Đăng ký</a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Nội dung chi tiết -->
    <main class="container my-4 flex-grow-1">
        <!-- Breadcrumb -->
        <nav aria-label="breadcrumb" class="mb-4">
            <ol class="breadcrumb mb-0">
                <li class="breadcrumb-item"><a href="<c:url value='/home'/>" class="text-decoration-none">Trang chủ</a></li>
                <li class="breadcrumb-item"><a href="<c:url value='/product'/>" class="text-decoration-none">Sản phẩm</a></li>
                <c:if test="${not empty product.category}">
                    <li class="breadcrumb-item">
                        <a href="<c:url value='/product?categoryId=${product.category.categoryId}'/>" class="text-decoration-none">
                            ${product.category.categoryname}
                        </a>
                    </li>
                </c:if>
                <li class="breadcrumb-item active text-truncate" style="max-width: 250px;" aria-current="page">
                    ${product.productName}
                </li>
            </ol>
        </nav>

        <c:choose>
            <c:when test="${not empty product}">
                <div class="row g-4 mb-5">
                    <!-- Khung ảnh sản phẩm -->
                    <div class="col-lg-5 col-md-6">
                        <div class="img-container shadow-sm border">
                            <c:choose>
                                <c:when test="${product.imageUrl.startsWith('http')}">
                                    <img src="${product.imageUrl}" alt="${product.productName}" class="product-main-img img-fluid">
                                </c:when>
                                <c:when test="${not empty product.imageUrl}">
                                    <img src="<c:url value='/image?fname=${product.imageUrl}'/>" alt="${product.productName}" class="product-main-img img-fluid">
                                </c:when>
                                <c:otherwise>
                                    <img src="https://via.placeholder.com/400?text=No+Image" alt="${product.productName}" class="product-main-img img-fluid">
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <!-- Thông tin chi tiết & Đặt mua -->
                    <div class="col-lg-7 col-md-6">
                        <div class="ps-lg-3">
                            <div class="mb-2">
                                <span class="badge bg-primary-subtle text-primary border border-primary-subtle px-3 py-1 rounded-pill">
                                    <i class="bi bi-tag-fill me-1"></i> ${product.category.categoryname}
                                </span>
                                <span class="badge bg-success-subtle text-success border border-success-subtle px-3 py-1 rounded-pill ms-1">
                                    <i class="bi bi-check2-circle me-1"></i> Còn hàng
                                </span>
                            </div>

                            <h2 class="fw-bold text-dark mb-3">${product.productName}</h2>

                            <!-- Giá bán -->
                            <div class="p-3 bg-white rounded-3 border mb-3">
                                <span class="text-muted small d-block">Giá niêm yết chính hãng:</span>
                                <span class="price-tag">
                                    <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                </span>
                            </div>

                            <!-- Form Thêm Vào Giỏ Hàng -->
                            <form action="<c:url value='/cart/add'/>" method="post" class="mb-4">
                                <input type="hidden" name="productId" value="${product.productId}">

                                <div class="mb-3">
                                    <label class="form-label fw-semibold text-secondary small text-uppercase">Số lượng</label>
                                    <div class="input-group" style="width: 140px;">
                                        <button class="btn btn-outline-secondary quantity-btn" type="button" onclick="decreaseQty()">-</button>
                                        <input type="number" id="quantity" name="quantity" class="form-control text-center fw-bold" value="1" min="1" max="99" readonly>
                                        <button class="btn btn-outline-secondary quantity-btn" type="button" onclick="increaseQty()">+</button>
                                    </div>
                                </div>

                                <div class="d-flex gap-2">
                                    <button type="submit" class="btn btn-warning btn-lg px-4 fw-bold shadow-sm flex-grow-1 text-dark">
                                        <i class="bi bi-cart-plus-fill me-2"></i> Thêm Vào Giỏ Hàng
                                    </button>
                                    <a href="<c:url value='/product'/>" class="btn btn-outline-secondary btn-lg px-3">
                                        <i class="bi bi-arrow-left"></i>
                                    </a>
                                </div>
                            </form>

                            <!-- Chính sách mua hàng cam kết -->
                            <div class="policy-card p-3">
                                <div class="row g-2">
                                    <div class="col-sm-6 d-flex align-items-center gap-2">
                                        <i class="bi bi-shield-check text-success fs-4"></i>
                                        <span class="small text-muted">Bảo hành 12 tháng chính hãng</span>
                                    </div>
                                    <div class="col-sm-6 d-flex align-items-center gap-2">
                                        <i class="bi bi-arrow-repeat text-primary fs-4"></i>
                                        <span class="small text-muted">Lỗi 1 đổi 1 trong vòng 30 ngày</span>
                                    </div>
                                    <div class="col-sm-6 d-flex align-items-center gap-2">
                                        <i class="bi bi-truck text-warning fs-4"></i>
                                        <span class="small text-muted">Giao hàng tận nơi toàn quốc</span>
                                    </div>
                                    <div class="col-sm-6 d-flex align-items-center gap-2">
                                        <i class="bi bi-headset text-info fs-4"></i>
                                        <span class="small text-muted">Hỗ trợ kỹ thuật 24/7 qua tổng đài</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Tab Mô tả chi tiết -->
                <div class="card border-0 shadow-sm mb-5">
                    <div class="card-header bg-white py-3 border-bottom">
                        <h5 class="fw-bold mb-0 text-dark">
                            <i class="bi bi-file-text me-2 text-primary"></i>Mô Tả & Thông Số Sản Phẩm
                        </h5>
                    </div>
                    <div class="card-body p-4">
                        <div class="text-secondary leading-relaxed" style="white-space: pre-line; line-height: 1.8;">
                            ${product.description != null && !product.description.isEmpty() ? product.description : 'Sản phẩm đang cập nhật thông số chi tiết.'}
                        </div>
                    </div>
                </div>

                <!-- Sản phẩm liên quan cùng danh mục -->
                <c:if test="${not empty relatedProducts}">
                    <div class="mb-4">
                        <h4 class="fw-bold text-dark mb-3">
                            <i class="bi bi-stars text-warning me-2"></i>Sản Phẩm Cùng Danh Mục
                        </h4>
                        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-3">
                            <c:forEach items="${relatedProducts}" var="rp">
                                <div class="col">
                                    <div class="card h-100 shadow-sm border-0 product-rel-card">
                                        <a href="<c:url value='/product/detail?id=${rp.productId}'/>" class="text-center overflow-hidden bg-white rounded-top p-3 d-flex align-items-center justify-content-center" style="height: 180px;">
                                            <c:choose>
                                                <c:when test="${rp.imageUrl.startsWith('http')}">
                                                    <img src="${rp.imageUrl}" class="img-fluid" alt="${rp.productName}" style="max-height: 100%; object-fit: contain;">
                                                </c:when>
                                                <c:when test="${not empty rp.imageUrl}">
                                                    <img src="<c:url value='/image?fname=${rp.imageUrl}'/>" class="img-fluid" alt="${rp.productName}" style="max-height: 100%; object-fit: contain;">
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="https://via.placeholder.com/180?text=No+Image" class="img-fluid" alt="${rp.productName}">
                                                </c:otherwise>
                                            </c:choose>
                                        </a>
                                        <div class="card-body d-flex flex-column p-3">
                                            <h6 class="card-title text-truncate mb-2" title="${rp.productName}">
                                                <a href="<c:url value='/product/detail?id=${rp.productId}'/>" class="text-dark text-decoration-none fw-semibold">
                                                    ${rp.productName}
                                                </a>
                                            </h6>
                                            <div class="mt-auto">
                                                <span class="text-danger fw-bold">
                                                    <fmt:formatNumber value="${rp.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </c:if>
            </c:when>
            <c:otherwise>
                <div class="text-center py-5 bg-white rounded-3 shadow-sm border">
                    <i class="bi bi-exclamation-circle fs-1 text-danger d-block mb-3"></i>
                    <h4 class="fw-bold">Không tìm thấy sản phẩm!</h4>
                    <p class="text-muted">Sản phẩm này có thể đã bị gỡ khỏi hệ thống hoặc đường dẫn không hợp lệ.</p>
                    <a href="<c:url value='/product'/>" class="btn btn-primary px-4">Quay lại danh sách sản phẩm</a>
                </div>
            </c:otherwise>
        </c:choose>
    </main>

    <!-- Footer -->
    <footer class="bg-white text-center py-3 border-top mt-auto text-muted small">
        <div class="container">
            &copy; 2026 BAI01 - SHOPPING ONLINE. All rights reserved.
        </div>
    </footer>

    <!-- Bootstrap 5 JS Bundle & Quantity Control Script -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function increaseQty() {
            const input = document.getElementById('quantity');
            let val = parseInt(input.value) || 1;
            if (val < 99) input.value = val + 1;
        }

        function decreaseQty() {
            const input = document.getElementById('quantity');
            let val = parseInt(input.value) || 1;
            if (val > 1) input.value = val - 1;
        }
    </script>
</body>
</html>