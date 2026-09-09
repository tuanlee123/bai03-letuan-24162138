package vn.iotstar.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.model.User;

import java.io.IOException;

@WebFilter(urlPatterns = { "/admin/*", "/profile" }, dispatcherTypes = { DispatcherType.REQUEST })
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Khởi tạo filter nếu cần
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("account") : null;
        String path = req.getServletPath();

        // 1. Kiểm tra trạng thái đăng nhập
        if (user == null) {
            // Chưa đăng nhập -> Lưu thông báo và chuyển hướng về /login
            req.getSession(true).setAttribute("error", "Vui lòng đăng nhập để tiếp tục truy cập!");
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // 2. Kiểm tra phân quyền truy cập vùng Quản trị (/admin/*)
        if (path.startsWith("/admin")) {
            // Quy ước: roleid == 1 là Quản trị viên (Admin)
            if (user.getRoleid() == null || user.getRoleid() != 1) {
                // Người dùng thông thường cố truy cập admin -> Trả về mã 403 hoặc đẩy về trang chủ
                req.getSession().setAttribute("error", "Bạn không có quyền truy cập vào khu vực Quản trị!");
                resp.sendRedirect(req.getContextPath() + "/home");
                return;
            }
        }

        // Đạt yêu cầu xác thực và phân quyền -> Cho request đi tiếp tới Controller
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Dọn dẹp tài nguyên khi filter bị hủy
    }
}