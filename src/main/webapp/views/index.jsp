<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cửa Hàng Trực Tuyến - SHOPPING ONLINE</title>
    <!-- Bootstrap 5 CSS & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .hero-banner {
            background: linear-gradient(135deg, #0d6efd 0%, #0a58ca 100%);
            border-radius: 16px;
        }
        .product-card {
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            border-radius: 12px;
            overflow: hidden;
        }
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.08) !important;
        }
        .product-img-wrapper {
            height: 200px;
            background-color: #f8f9fa;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 15px;
        }
        .product-img {
            max-height: 100%;
            max-width: 100%;
            object-fit: contain;
        }
        .category-badge {
            transition: all 0.2s;
            border-radius: 20px;
        }
        .category-badge:hover {
            background-color: #0d6efd !important;
            color: #fff !important;
        }
    </style>
</head>
<body class="bg-light d-flex flex-column min-vh-100">

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top shadow-sm py-3">
        <div class="container">
            <a class="navbar-brand fw-bold text-warning fs-4" href="<c:url value='/home'/>">
                <i class="bi bi-cart3 me-2"></i>SHOPPING ONLINE
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navMain">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navMain">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link active" href="<c:url value='/home'/>"><i class="bi bi-house-door me-1"></i>Trang chủ</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value='/product'/>"><i class="bi bi-grid me-1"></i>Tất cả sản phẩm</a>
                    </li>
                </ul>

                <!-- Form tìm kiếm -->
                <form class="d-flex me-3" action="<c:url value='/product'/>" method="get">
                    <div class="input-group">
                        <input class="form-control form-control-sm" type="search" name="keyword" placeholder="Tìm sản phẩm..." aria-label="Search">
                        <button class="btn btn-outline-warning btn-sm" type="submit"><i class="bi bi-search"></i></button>
                    </div>
                </form>

                <!-- Giỏ hàng & Tài khoản -->
                <ul class="navbar-nav align-items-center">
                    <li class="nav-item me-2">
                        <a class="btn btn-outline-light btn-sm position-relative px-3" href="<c:url value='/cart'/>">
                            <i class="bi bi-bag-check me-1"></i>Giỏ hàng
                            <c:if test="${not empty sessionScope.cart}">
                                <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                                    ${sessionScope.cart.size()}
                                </span>
                            </c:if>
                        </a>
                    </li>

                    <c:choose>
                        <c:when test="${not empty sessionScope.account}">
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle text-white fw-semibold" href="#" role="button" data-bs-toggle="dropdown">
                                    <i class="bi bi-person-circle me-1"></i>${sessionScope.account.username}
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end shadow">
                                    <li><a class="dropdown-item" href="<c:url value='/profile'/>"><i class="bi bi-person me-2"></i>Hồ sơ</a></li>
                                    <li><a class="dropdown-item text-primary" href="<c:url value='/admin/home'/>"><i class="bi bi-shield-lock me-2"></i>Trang Quản Trị</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item text-danger" href="<c:url value='/logout'/>"><i class="bi bi-box-arrow-right me-2"></i>Đăng xuất</a></li>
                                </ul>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item">
                                <a class="btn btn-warning btn-sm fw-semibold text-dark px-3" href="<c:url value='/login'/>">
                                    <i class="bi bi-box-arrow-in-right me-1"></i>Đăng nhập
                                </a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <main class="container my-4 flex-grow-1">

        <!-- Banner Hero -->
        <div class="hero-banner text-white p-5 mb-5 shadow-sm text-center text-md-start">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h1 class="display-5 fw-bold mb-3">Chào mừng đến với Cửa Hàng Trực Tuyến!</h1>
                    <p class="lead text-white-50 mb-4">Khám phá các sản phẩm công nghệ chất lượng hàng đầu với mức giá tốt nhất hôm nay.</p>
                    <a href="<c:url value='/product'/>" class="btn btn-warning btn-lg fw-bold text-dark px-4 shadow">
                        Mua Sắm Ngay <i class="bi bi-arrow-right ms-1"></i>
                    </a>
                </div>
                <div class="col-md-4 text-center d-none d-md-block">
                    <i class="bi bi-laptop display-1 opacity-75"></i>
                </div>
            </div>
        </div>

        <!-- Danh mục sản phẩm -->
        <c:if test="${not empty listcate or not empty categories}">
            <div class="mb-5">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h5 class="fw-bold text-dark mb-0"><i class="bi bi-tags-fill me-2 text-primary"></i>Danh Mục Sản Phẩm</h5>
                </div>
                <div class="d-flex gap-2 flex-wrap">
                    <c:forEach items="${not empty listcate ? listcate : categories}" var="c">
                        <a href="<c:url value='/product?categoryId=${c.categoryId}'/>" class="category-badge btn btn-light border py-2 px-3 fw-semibold text-secondary">
                            <i class="bi bi-folder2 me-1"></i>${c.categoryname}
                        </a>
                    </c:forEach>
                </div>
            </div>
        </c:if>

        <!-- Tiêu đề danh sách mới nhất -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h4 class="fw-bold text-dark mb-1"><i class="bi bi-stars me-2 text-warning"></i>Sản Phẩm Mới Nhất</h4>
                <p class="text-muted small mb-0">Các dòng máy mới cập nhật từ hệ thống kho hàng</p>
            </div>
            <a href="<c:url value='/product'/>" class="btn btn-outline-primary btn-sm fw-semibold">
                Xem tất cả <i class="bi bi-arrow-right ms-1"></i>
            </a>
        </div>

        <!-- Lưới sản phẩm -->
        <c:set var="displayList" value="${not empty latestProducts ? latestProducts : listproduct}" />

        <c:choose>
            <c:when test="${not empty displayList}">
                <div class="row g-4">
                    <c:forEach items="${displayList}" var="p">
                        <div class="col-xl-3 col-lg-4 col-md-6 col-sm-6">
                            <div class="card h-100 border-0 shadow-sm product-card bg-white">
                                <div class="product-img-wrapper position-relative">
                                    <c:choose>
                                        <c:when test="${not empty p.imageUrl and p.imageUrl.startsWith('http')}">
                                            <img src="${p.imageUrl}" alt="${p.productName}" class="product-img">
                                        </c:when>
                                        <c:when test="${not empty p.imageUrl}">
                                            <img src="<c:url value='/image?fname=${p.imageUrl}'/>" alt="${p.productName}" class="product-img">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="https://via.placeholder.com/200?text=No+Image" alt="No Image" class="product-img">
                                        </c:otherwise>
                                    </c:choose>
                                    <c:if test="${p.category != null}">
                                        <span class="badge bg-dark bg-opacity-75 position-absolute top-0 start-0 m-2 px-2 py-1 small">
                                            ${p.category.categoryname}
                                        </span>
                                    </c:if>
                                </div>

                                <div class="card-body d-flex flex-column p-3">
                                    <h6 class="card-title fw-bold text-dark mb-2 text-truncate" title="${p.productName}">
                                        <a href="<c:url value='/product/detail?id=${p.productId}'/>" class="text-dark text-decoration-none">
                                            ${p.productName}
                                        </a>
                                    </h6>
                                    
                                    <div class="mt-auto">
                                        <div class="text-danger fw-bold fs-5 mb-3">
                                            <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                        </div>
                                        <div class="d-grid gap-2">
                                            <a href="<c:url value='/cart/add?productId=${p.productId}&quantity=1'/>" class="btn btn-warning btn-sm fw-bold text-dark">
                                                <i class="bi bi-cart-plus me-1"></i> Thêm Giỏ Hàng
                                            </a>
                                            <a href="<c:url value='/product/detail?id=${p.productId}'/>" class="btn btn-outline-secondary btn-sm">
                                                Chi Tiết
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="card border-0 shadow-sm p-5 text-center my-4">
                    <div class="text-muted">
                        <i class="bi bi-box-seam display-3 d-block mb-3 opacity-50"></i>
                        <h5 class="fw-bold text-secondary">Chưa có sản phẩm nào trong kho hàng</h5>
                        <p class="small text-muted mb-3">Vui lòng thêm sản phẩm từ trang quản trị để hiển thị.</p>
                        <a href="<c:url value='/admin/product/add'/>" class="btn btn-outline-primary btn-sm">
                            <i class="bi bi-plus-circle me-1"></i>Thêm sản phẩm (Admin)
                        </a>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>

    </main>

    <!-- Footer -->
    <footer class="bg-dark text-white py-4 mt-auto border-top">
        <div class="container text-center">
            <p class="mb-1 fw-bold text-warning">SHOPPING ONLINE &copy; 2026</p>
            <small class="text-white-50">Hệ thống website thương mại điện tử Jakarta EE 10 & Tomcat 10.1</small>
        </div>
    </footer>

    <!-- Bootstrap 5 Bundle JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>