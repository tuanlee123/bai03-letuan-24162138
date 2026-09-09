<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tất Cả Sản Phẩm - Cửa Hàng Trực Tuyến</title>
    <!-- Bootstrap 5 CSS & Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .product-card {
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            border-radius: 12px;
            overflow: hidden;
        }
        .product-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.08) !important;
        }
        .product-img-wrap {
            height: 200px;
            background-color: #f8f9fa;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 12px;
        }
        .product-img-wrap img {
            max-height: 100%;
            max-width: 100%;
            object-fit: contain;
            transition: transform 0.3s ease;
        }
        .product-card:hover .product-img-wrap img {
            transform: scale(1.05);
        }
        .filter-sidebar {
            background-color: #fff;
            border-radius: 12px;
        }
        .price-badge {
            font-size: 1.15rem;
        }
    </style>
</head>
<body class="bg-light d-flex flex-column min-vh-100">

    <!-- Header / Navbar Khách Hàng -->
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

    <!-- Main Container -->
    <main class="container my-4 flex-grow-1">
        <!-- Breadcrumb chỉ mục -->
        <nav aria-label="breadcrumb" class="mb-3">
            <ol class="breadcrumb mb-0">
                <li class="breadcrumb-item"><a href="<c:url value='/home'/>" class="text-decoration-none">Trang chủ</a></li>
                <li class="breadcrumb-item active" aria-current="page">Danh sách sản phẩm</li>
            </ol>
        </nav>

        <div class="row g-4">
            <!-- Cột trái: Bộ lọc sản phẩm (Sidebar Filter) -->
            <aside class="col-lg-3 col-md-4">
                <div class="filter-sidebar p-3 shadow-sm border">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5 class="fw-bold mb-0 text-dark">
                            <i class="bi bi-sliders me-1 text-primary"></i> Bộ Lọc
                        </h5>
                        <a href="<c:url value='/product'/>" class="btn btn-sm btn-link text-decoration-none p-0 text-muted">Xóa lọc</a>
                    </div>

                    <form action="<c:url value='/product'/>" method="get">
                        <!-- 1. Tìm theo từ khóa -->
                        <div class="mb-3">
                            <label class="form-label small fw-bold text-secondary text-uppercase">Từ khóa</label>
                            <div class="input-group input-group-sm">
                                <input type="text" name="keyword" value="${param.keyword}" class="form-control" placeholder="Tên sản phẩm...">
                                <button class="btn btn-primary" type="submit"><i class="bi bi-search"></i></button>
                            </div>
                        </div>

                        <hr class="my-3 text-muted">

                        <!-- 2. Lọc theo danh mục -->
                        <div class="mb-3">
                            <label class="form-label small fw-bold text-secondary text-uppercase">Danh mục mặt hàng</label>
                            <div class="list-group list-group-flush">
                                <a href="<c:url value='/product'/>" class="list-group-item list-group-item-action border-0 px-2 py-1 rounded ${empty param.categoryId ? 'fw-bold text-primary bg-light' : 'text-secondary'}">
                                    <i class="bi bi-chevron-right me-1 small"></i> Tất cả danh mục
                                </a>
                                <c:forEach items="${listcate}" var="c">
                                    <a href="<c:url value='/product?categoryId=${c.categoryId}'/>" 
                                       class="list-group-item list-group-item-action border-0 px-2 py-1 rounded ${param.categoryId == c.categoryId ? 'fw-bold text-primary bg-light' : 'text-secondary'}">
                                        <i class="bi bi-chevron-right me-1 small"></i> ${c.categoryname}
                                    </a>
                                </c:forEach>
                            </div>
                            <!-- Giữ lại categoryId khi người dùng submit form lọc giá -->
                            <c:if test="${not empty param.categoryId}">
                                <input type="hidden" name="categoryId" value="${param.categoryId}">
                            </c:if>
                        </div>

                        <hr class="my-3 text-muted">

                        <!-- 3. Bộ lọc khoảng giá -->
                        <div class="mb-3">
                            <label class="form-label small fw-bold text-secondary text-uppercase">Khoảng giá (VNĐ)</label>
                            <div class="row g-2 mb-2">
                                <div class="col-6">
                                    <input type="number" name="minPrice" value="${param.minPrice}" class="form-control form-control-sm" placeholder="Từ" min="0" step="50000">
                                </div>
                                <div class="col-6">
                                    <input type="number" name="maxPrice" value="${param.maxPrice}" class="form-control form-control-sm" placeholder="Đến" min="0" step="50000">
                                </div>
                            </div>

                            <!-- Các mức giá gợi ý chọn nhanh -->
                            <div class="d-flex flex-column gap-1 small mt-2">
                                <a href="<c:url value='/product?maxPrice=5000000${not empty param.categoryId ? "&categoryId=".concat(param.categoryId) : ""}'/>" class="text-decoration-none text-muted">
                                    <i class="bi bi-dash"></i> Dưới 5 triệu
                                </a>
                                <a href="<c:url value='/product?minPrice=5000000&maxPrice=15000000${not empty param.categoryId ? "&categoryId=".concat(param.categoryId) : ""}'/>" class="text-decoration-none text-muted">
                                    <i class="bi bi-dash"></i> 5 triệu - 15 triệu
                                </a>
                                <a href="<c:url value='/product?minPrice=15000000&maxPrice=25000000${not empty param.categoryId ? "&categoryId=".concat(param.categoryId) : ""}'/>" class="text-decoration-none text-muted">
                                    <i class="bi bi-dash"></i> 15 triệu - 25 triệu
                                </a>
                                <a href="<c:url value='/product?minPrice=25000000${not empty param.categoryId ? "&categoryId=".concat(param.categoryId) : ""}'/>" class="text-decoration-none text-muted">
                                    <i class="bi bi-dash"></i> Trên 25 triệu
                                </a>
                            </div>
                        </div>

                        <button type="submit" class="btn btn-warning w-100 btn-sm fw-bold mt-2 shadow-sm text-dark">
                            <i class="bi bi-funnel-fill me-1"></i> Áp Dụng Lọc
                        </button>
                    </form>
                </div>
            </aside>

            <!-- Cột phải: Lưới danh sách sản phẩm -->
            <section class="col-lg-9 col-md-8">
                <div class="d-flex justify-content-between align-items-center mb-3 bg-white p-3 rounded-3 border shadow-sm">
                    <div>
                        <h4 class="fw-bold text-dark mb-0">Tất Cả Sản Phẩm</h4>
                        <small class="text-muted">
                            Hiển thị <strong>${listproduct != null ? listproduct.size() : 0}</strong> sản phẩm phù hợp
                        </small>
                    </div>
                </div>

                <!-- Lưới hiển thị các thẻ Card -->
                <div class="row row-cols-1 row-cols-sm-2 row-cols-md-2 row-cols-lg-3 g-3">
                    <c:choose>
                        <c:when test="${not empty listproduct}">
                            <c:forEach items="${listproduct}" var="p">
                                <div class="col">
                                    <div class="card h-100 shadow-sm border-0 product-card">
                                        <a href="<c:url value='/product/detail?id=${p.productId}'/>" class="product-img-wrap text-decoration-none">
                                            <c:choose>
                                                <c:when test="${p.imageUrl.startsWith('http')}">
                                                    <img src="${p.imageUrl}" alt="${p.productName}">
                                                </c:when>
                                                <c:when test="${not empty p.imageUrl}">
                                                    <img src="<c:url value='/image?fname=${p.imageUrl}'/>" alt="${p.productName}">
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="https://via.placeholder.com/200?text=No+Image" alt="${p.productName}">
                                                </c:otherwise>
                                            </c:choose>
                                        </a>
                                        <div class="card-body d-flex flex-column p-3">
                                            <div class="mb-2">
                                                <span class="badge bg-light text-secondary border">
                                                    ${p.category.categoryname}
                                                </span>
                                            </div>
                                            <h6 class="card-title mb-2 text-truncate" title="${p.productName}">
                                                <a href="<c:url value='/product/detail?id=${p.productId}'/>" class="text-dark text-decoration-none fw-semibold">
                                                    ${p.productName}
                                                </a>
                                            </h6>
                                            <p class="card-text text-muted small text-truncate mb-3" title="${p.description}">
                                                ${p.description != null && !p.description.isEmpty() ? p.description : 'Sản phẩm chính hãng chất lượng cao.'}
                                            </p>
                                            <div class="mt-auto d-flex justify-content-between align-items-center pt-2 border-top">
                                                <span class="text-danger fw-bold price-badge">
                                                    <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                                </span>
                                                <a href="<c:url value='/product/detail?id=${p.productId}'/>" class="btn btn-outline-primary btn-sm rounded-pill px-3">
                                                    Xem chi tiết
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="col-12 text-center py-5 bg-white rounded-3 border shadow-sm">
                                <i class="bi bi-search fs-1 text-muted opacity-50 d-block mb-3"></i>
                                <h5 class="fw-bold text-dark">Không tìm thấy sản phẩm nào!</h5>
                                <p class="text-muted small mb-3">Thử thay đổi từ khóa hoặc thiết lập lại khoảng giá lọc.</p>
                                <a href="<c:url value='/product'/>" class="btn btn-primary btn-sm px-4">
                                    Xem tất cả sản phẩm
                                </a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </section>
        </div>
    </main>

    <!-- Footer -->
    <footer class="bg-white text-center py-3 border-top mt-auto text-muted small">
        <div class="container">
            &copy; 2026 BAI01 - SHOPPING ONLINE. All rights reserved.
        </div>
    </footer>

    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>