<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property='title'/> - Cửa Hàng</title>
    <!-- Template Bootstrap 5 CDN đặt duy nhất tại Layout này -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <sitemesh:write property='head'/>
</head>
<body class="bg-light d-flex flex-column min-vh-100">

    <!-- Navbar chung -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top shadow-sm py-2">
        <div class="container">
            <a class="navbar-brand fw-bold text-warning" href="<c:url value='/home'/>">
                <i class="bi bi-shop me-2"></i>SHOPPING ONLINE
            </a>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item"><a class="nav-link text-white" href="<c:url value='/home'/>">Trang chủ</a></li>
                    <li class="nav-item"><a class="nav-link text-white" href="<c:url value='/product'/>">Tất cả sản phẩm</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Nơi SiteMesh 3 nhúng nội dung file con vào -->
    <main class="container py-4 flex-grow-1">
        <sitemesh:write property='body'/>
    </main>

    <!-- Footer chung -->
    <footer class="bg-white py-3 border-top text-center text-muted small mt-auto">
        <p class="mb-0">© 2026 Shopping Service MVC</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>