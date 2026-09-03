<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><sitemesh:title default="Shopping Service" /></title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: Arial, sans-serif; background-color: #f4f6f9; color: #333; display: flex; flex-direction: column; min-height: 100vh; }
        header { background: #007bff; color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        header .logo { font-size: 20px; font-weight: bold; text-decoration: none; color: white; }
        header nav a { color: white; text-decoration: none; margin-left: 20px; font-weight: 500; }
        header nav a:hover { text-decoration: underline; color: #ffdd57; }
        .main-container { flex: 1; width: 90%; max-width: 1100px; margin: 25px auto; background: white; padding: 25px; border-radius: 8px; box-shadow: 0 1px 4px rgba(0,0,0,0.08); }
        footer { background: #343a40; color: #bbb; text-align: center; padding: 15px 0; font-size: 14px; margin-top: auto; }
    </style>
    <sitemesh:head />
</head>
<body>

    <header>
        <a href="<c:url value='/home'/>" class="logo">🛍️ ShoppingService</a>
        <nav>
            <a href="<c:url value='/home'/>">Trang chủ</a>
            <a href="<c:url value='/product'/>">Sản phẩm</a>
            
            <%-- Kiểm tra biến session 'account' --%>
            <c:choose>
                <c:when test="${not empty sessionScope.account}">
                    <a href="<c:url value='/profile'/>">Hồ sơ (${sessionScope.account.fullname})</a>
                    
                    <%-- Nếu là Admin (roleid = 1) --%>
                    <c:if test="${sessionScope.account.roleid == 1}">
                        <a href="<c:url value='/admin/products'/>" style="color: #ffdd57; border: 1px solid #ffdd57; padding: 3px 8px; border-radius: 4px;">⚙️ Quản trị</a>
                    </c:if>
                    
                    <a href="<c:url value='/logout'/>">Đăng xuất</a>
                </c:when>
                <c:otherwise>
                    <a href="<c:url value='/login'/>">Đăng nhập</a>
                    <a href="<c:url value='/register'/>">Đăng ký</a>
                </c:otherwise>
            </c:choose>
        </nav>
    </header>

    <div class="main-container">
        <!-- Nội dung của trang con sẽ đổ vào đây -->
        <sitemesh:body />
    </div>

    <footer>
        <p>&copy; 2026 ShoppingService. Phát triển với JPA & SiteMesh.</p>
    </footer>

</body>
</html>