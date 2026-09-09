package vn.iotstar.controller;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpSession;
import vn.iotstar.model.User;
import vn.iotstar.service.IUserService;
import vn.iotstar.util.EmailUtil;

@Controller
public class RegisterController {

    @Autowired
    private IUserService userService;

    // 1. Mở trang đăng ký
    @GetMapping("/register")
    public String showRegisterForm() {
        return "web/register";
    }

    // 2. Xử lý đăng ký & gửi OTP kích hoạt
    @PostMapping("/register")
    public String handleRegister(@RequestParam("username") String username,
                                 @RequestParam("fullname") String fullname,
                                 @RequestParam("email") String email,
                                 @RequestParam("phone") String phone,
                                 @RequestParam("password") String password,
                                 @RequestParam("confirmPassword") String confirmPassword,
                                 HttpSession session,
                                 Model model) {
        if (!password.equals(confirmPassword)) {
            model.addAttribute("error", "Mật khẩu xác nhận không khớp!");
            return "web/register";
        }

        if (userService.findByUsername(username) != null) {
            model.addAttribute("error", "Tên đăng nhập đã tồn tại!");
            return "web/register";
        }

        if (userService.findByEmail(email) != null) {
            model.addAttribute("error", "Email này đã được sử dụng!");
            return "web/register";
        }

        // Tạo mã OTP 6 chữ số
        String otp = EmailUtil.generateOTP();

        // Lưu tạm User vào Session chờ xác thực
        User tempUser = new User();
        tempUser.setUsername(username);
        tempUser.setFullname(fullname);
        tempUser.setEmail(email);
        tempUser.setPhone(phone);
        tempUser.setPassword(password);
        tempUser.setRoleid(2); // Role 2: User thường
        tempUser.setImages("avatar.png");
        tempUser.setCreatedDate(new Date());

        session.setAttribute("tempUser", tempUser);
        session.setAttribute("regOTP", otp);

        // Gửi email OTP
        String content = "<h3>Mã OTP kích hoạt tài khoản của bạn là: <b style='color:red; font-size:20px;'>" + otp + "</b></h3>"
                + "<p>Mã này có hiệu lực trong phiên đăng ký hiện tại. Vui lòng không chia sẻ cho ai khác.</p>";
        EmailUtil.sendEmail(email, "Kích hoạt tài khoản - Xác nhận OTP", content);

        return "redirect:/verify-otp";
    }

    // 3. Mở trang nhập mã OTP
    @GetMapping("/verify-otp")
    public String showVerifyOtpForm() {
        return "web/verify-otp";
    }

    // 4. Xác thực OTP và lưu User vào CSDL
    @PostMapping("/verify-otp")
    public String handleVerifyOtp(@RequestParam("otp") String inputOtp,
                                  HttpSession session,
                                  Model model) {
        String sessionOtp = (String) session.getAttribute("regOTP");
        User tempUser = (User) session.getAttribute("tempUser");

        if (sessionOtp != null && sessionOtp.equals(inputOtp) && tempUser != null) {
            userService.insert(tempUser);

            session.removeAttribute("regOTP");
            session.removeAttribute("tempUser");

            model.addAttribute("message", "Kích hoạt tài khoản thành công! Bạn có thể đăng nhập ngay.");
            return "web/login";
        } else {
            model.addAttribute("error", "Mã OTP không hợp lệ hoặc đã hết hạn!");
            return "web/verify-otp";
        }
    }
}