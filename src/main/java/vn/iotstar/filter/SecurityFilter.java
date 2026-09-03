package vn.iotstar.filter;

import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.model.User;

// Lệnh này chỉ định "bác bảo vệ" sẽ đứng gác ở mọi đường dẫn bắt đầu bằng /admin/
@WebFilter(urlPatterns = {"/admin/*"})
public class SecurityFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Khởi tạo Filter (để trống nếu không cần thiết lập gì thêm)
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        HttpSession session = req.getSession();

        // 1. Lấy thông tin user đang đăng nhập từ Session
        User currentUser = (User) session.getAttribute("account");

        // 2. CHƯA ĐĂNG NHẬP -> Đá văng về trang đăng nhập
        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return; // Quan trọng: return để ngắt luồng ngay lập tức
        }

        // 3. ĐÃ ĐĂNG NHẬP NHƯNG LÀ USER THƯỜNG (roleid != 1) -> Đá về trang chủ
        if (currentUser.getRoleid() == null || currentUser.getRoleid() != 1) {
            // Ở đây bạn có thể dùng lỗi 403 (resp.sendError(403)) 
            // Nhưng chuyển hướng về /home sẽ thân thiện với người dùng hơn
            resp.sendRedirect(req.getContextPath() + "/home");
            return; 
        }

        // 4. LÀ ADMIN (roleid = 1) -> Mời sếp vào trong (Cho phép request đi tiếp tới Controller)
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Hủy Filter khi server tắt
    }
}