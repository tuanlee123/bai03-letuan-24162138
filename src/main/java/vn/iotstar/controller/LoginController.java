package vn.iotstar.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.model.User;
import vn.iotstar.service.IUserService;

@Controller
public class LoginController {

    @Autowired
    private IUserService userService;

    // 1. Mở trang đăng nhập (đọc Cookie nếu có)
    @GetMapping("/login")
    public String showLoginForm(@CookieValue(name = "username", required = false) String cookieUsername,
                                Model model) {
        if (cookieUsername != null && !cookieUsername.isEmpty()) {
            model.addAttribute("username", cookieUsername);
            model.addAttribute("remember", true);
        }
        return "web/login";
    }

    // 2. Xử lý đăng nhập
    @PostMapping("/login")
    public String processLogin(@RequestParam("username") String username,
                               @RequestParam("password") String password,
                               @RequestParam(name = "remember", required = false) String remember,
                               HttpSession session,
                               HttpServletRequest req,
                               HttpServletResponse resp,
                               Model model) {
        // Server-side validation
        if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            model.addAttribute("error", "Tên đăng nhập và mật khẩu không được để trống!");
            model.addAttribute("username", username);
            return "web/login";
        }

        // Xác thực tài khoản qua Service
        User user = userService.login(username.trim(), password.trim());

        if (user != null) {
            session.setAttribute("account", user);

            // Xử lý Cookie Remember Me
            Cookie cookieUser = new Cookie("username", username.trim());
            if ("on".equals(remember) || "true".equals(remember)) {
                cookieUser.setMaxAge(60 * 60 * 24 * 7); // 7 ngày
            } else {
                cookieUser.setMaxAge(0); // Xóa cookie
            }
            cookieUser.setPath(req.getContextPath().isEmpty() ? "/" : req.getContextPath());
            resp.addCookie(cookieUser);

            // Phân quyền theo roleid (1: Admin, còn lại: User)
            if (user.getRoleid() != null && user.getRoleid() == 1) {
                return "redirect:/admin/home";
            } else {
                return "redirect:/home";
            }
        } else {
            model.addAttribute("error", "Tài khoản hoặc mật khẩu không chính xác!");
            model.addAttribute("username", username);
            return "web/login";
        }
    }
}