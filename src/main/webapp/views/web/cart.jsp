<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ Hàng Của Bạn - SHOPPING ONLINE</title>
    <!-- Bootstrap 5 CSS & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .cart-img {
            width: 70px;
            height: 70px;
            object-fit: contain;
            background-color: #f8f9fa;
            border-radius: 8px;
            padding: 4px;
        }
        .qty-input-group {
            width: 120px;
        }
        .qty-btn {
            width: 32px;
            height: 32px;
            padding: 0;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .order-summary-card {
            border-radius: 12px;
            position: sticky;
            top: 80px;
        }
        .table > tbody > tr > td {
            vertical-align: middle;
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
                        <a class="nav-link" href="<c:url value='/product'/>"><i class="bi bi-grid me-1"></i>Sản phẩm</a>
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
                                <a class="btn btn-warning btn-sm px-3 fw-semibold text-dark" href="<c:url value='/register'/>">Đăng ký</a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <main class="container my-4 flex-grow-1">
        <!-- Breadcrumb -->
        <nav aria-label="breadcrumb" class="mb-4">
            <ol class="breadcrumb mb-0">
                <li class="breadcrumb-item"><a href="<c:url value='/home'/>" class="text-decoration-none">Trang chủ</a></li>
                <li class="breadcrumb-item active" aria-current="page">Giỏ hàng</li>
            </ol>
        </nav>

        <h3 class="fw-bold text-dark mb-4">
            <i class="bi bi-bag-check me-2 text-primary"></i>Giỏ Hàng Của Bạn
        </h3>

        <!-- Khởi tạo biến tính tổng tiền -->
        <c:set var="totalPrice" value="0" />

        <c:choose>
            <%-- Kiểm tra nếu giỏ hàng có dữ liệu (hỗ trợ cả sessionScope.cart hoặc requestScope.cart dạng Map hoặc List) --%>
            <c:when test="${not empty sessionScope.cart or not empty cart}">
                <div class="row g-4">
                    <!-- Bảng chi tiết sản phẩm giỏ hàng -->
                    <div class="col-lg-8">
                        <div class="card border-0 shadow-sm">
                            <div class="card-body p-0">
                                <div class="table-responsive">
                                    <table class="table table-hover align-middle mb-0">
                                        <thead class="table-light">
                                            <tr>
                                                <th style="width: 100px;">Sản phẩm</th>
                                                <th>Mô tả</th>
                                                <th class="text-center" style="width: 130px;">Đơn giá</th>
                                                <th class="text-center" style="width: 150px;">Số lượng</th>
                                                <th class="text-end" style="width: 130px;">Thành tiền</th>
                                                <th class="text-center" style="width: 60px;"></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%-- Duyệt qua giỏ hàng. Hỗ trợ đối tượng CartItem: item.product, item.quantity, item.unitPrice --%>
                                            <c:forEach items="${not empty sessionScope.cart ? sessionScope.cart : cart}" var="entry">
                                                <c:set var="item" value="${entry.value != null ? entry.value : entry}" />
                                                <c:set var="itemSubtotal" value="${item.product.price * item.quantity}" />
                                                <c:set var="totalPrice" value="${totalPrice + itemSubtotal}" />

                                                <tr>
                                                    <!-- Ảnh -->
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${item.product.imageUrl.startsWith('http')}">
                                                                <img src="${item.product.imageUrl}" alt="${item.product.productName}" class="cart-img border">
                                                            </c:when>
                                                            <c:when test="${not empty item.product.imageUrl}">
                                                                <img src="<c:url value='/image?fname=${item.product.imageUrl}'/>" alt="${item.product.productName}" class="cart-img border">
                                                            </c:when>
                                                            <c:otherwise>
                                                                <img src="https://via.placeholder.com/70?text=No+Img" alt="${item.product.productName}" class="cart-img border">
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>

                                                    <!-- Tên và danh mục -->
                                                    <td>
                                                        <a href="<c:url value='/product/detail?id=${item.product.productId}'/>" class="text-dark fw-semibold text-decoration-none d-block mb-1">
                                                            ${item.product.productName}
                                                        </a>
                                                        <c:if test="${not empty item.product.category}">
                                                            <span class="badge bg-light text-secondary border">
                                                                ${item.product.category.categoryname}
                                                            </span>
                                                        </c:if>
                                                    </td>

                                                    <!-- Đơn giá -->
                                                    <td class="text-center fw-semibold text-secondary">
                                                        <fmt:formatNumber value="${item.product.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                                    </td>

                                                    <!-- Tăng giảm số lượng -->
                                                    <td class="text-center">
                                                        <form action="<c:url value='/cart/update'/>" method="post" class="d-inline-flex align-items-center qty-input-group">
                                                            <input type="hidden" name="productId" value="${item.product.productId}">
                                                            <a href="<c:url value='/cart/update?productId=${item.product.productId}&action=decrease'/>" 
                                                               class="btn btn-outline-secondary btn-sm qty-btn ${item.quantity <= 1 ? 'disabled' : ''}">-</a>
                                                            <input type="number" name="quantity" value="${item.quantity}" class="form-control form-control-sm text-center mx-1 fw-bold" min="1" max="99" readonly>
                                                            <a href="<c:url value='/cart/update?productId=${item.product.productId}&action=increase'/>" 
                                                               class="btn btn-outline-secondary btn-sm qty-btn">+</a>
                                                        </form>
                                                    </td>

                                                    <!-- Thành tiền -->
                                                    <td class="text-end fw-bold text-danger">
                                                        <fmt:formatNumber value="${itemSubtotal}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                                    </td>

                                                    <!-- Nút Xóa -->
                                                    <td class="text-center">
                                                        <a href="<c:url value='/cart/remove?productId=${item.product.productId}'/>" 
                                                           class="btn btn-outline-danger btn-sm border-0" 
                                                           onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này khỏi giỏ hàng?');" 
                                                           title="Xóa sản phẩm">
                                                            <i class="bi bi-trash fs-5"></i>
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div class="card-footer bg-white p-3 d-flex justify-content-between align-items-center border-top">
                                <a href="<c:url value='/product'/>" class="btn btn-outline-secondary btn-sm">
                                    <i class="bi bi-arrow-left me-1"></i> Tiếp tục mua sắm
                                </a>
                                <a href="<c:url value='/cart/clear'/>" class="btn btn-outline-danger btn-sm" onclick="return confirm('Bạn có chắc muốn làm trống toàn bộ giỏ hàng?');">
                                    <i class="bi bi-trash3 me-1"></i> Xóa toàn bộ giỏ
                                </a>
                            </div>
                        </div>
                    </div>

                    <!-- Khối Tóm Tắt Đơn Hàng (Order Summary) -->
                    <div class="col-lg-4">
                        <div class="card border-0 shadow-sm order-summary-card">
                            <div class="card-header bg-white py-3 border-bottom">
                                <h5 class="fw-bold mb-0 text-dark">Tóm Tắt Đơn Hàng</h5>
                            </div>
                            <div class="card-body p-4">
                                <div class="d-flex justify-content-between mb-2">
                                    <span class="text-muted">Tạm tính:</span>
                                    <span class="fw-semibold text-dark">
                                        <fmt:formatNumber value="${totalPrice}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                    </span>
                                </div>
                                <div class="d-flex justify-content-between mb-3">
                                    <span class="text-muted">Phí vận chuyển:</span>
                                    <span class="text-success fw-semibold">Miễn phí</span>
                                </div>
                                <hr class="text-muted">
                                <div class="d-flex justify-content-between mb-4">
                                    <span class="fs-5 fw-bold text-dark">Tổng thanh toán:</span>
                                    <span class="fs-4 fw-bold text-danger">
                                        <fmt:formatNumber value="${totalPrice}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                    </span>
                                </div>

                                <a href="<c:url value='/checkout'/>" class="btn btn-warning w-100 py-3 fw-bold text-dark shadow-sm">
                                    <i class="bi bi-credit-card me-1"></i> TIẾN HÀNH ĐẶT HÀNG
                                </a>

                                <div class="mt-3 text-center">
                                    <small class="text-muted d-block"><i class="bi bi-shield-check text-success me-1"></i> Bảo mật thanh toán 100%</small>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:when>
            <%-- Khi giỏ hàng trống --%>
            <c:otherwise>
                <div class="card border-0 shadow-sm p-5 text-center">
                    <div class="py-4">
                        <i class="bi bi-cart-x text-muted opacity-50 display-1 d-block mb-3"></i>
                        <h4 class="fw-bold text-dark mb-2">Giỏ hàng của bạn đang trống!</h4>
                        <p class="text-muted mb-4">Hãy chọn thêm các sản phẩm công nghệ tuyệt vời từ cửa hàng của chúng tôi.</p>
                        <a href="<c:url value='/product'/>" class="btn btn-primary px-4 py-2 fw-semibold">
                            <i class="bi bi-bag-plus me-1"></i> Khám phá sản phẩm ngay
                        </a>
                    </div>
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

    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>