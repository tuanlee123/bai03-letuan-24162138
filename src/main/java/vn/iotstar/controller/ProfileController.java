package vn.iotstar.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.http.HttpSession;
import vn.iotstar.model.User;
import vn.iotstar.service.IUserService;
import vn.iotstar.util.Constant;

@Controller
@RequestMapping("/profile")
public class ProfileController {

    @Autowired
    private IUserService userService;

    @Value("${app.upload.dir:" + Constant.DIR + "}")
    private String uploadDir;

    // 1. Mở trang thông tin hồ sơ
    @GetMapping({"", "/"})
    public String showProfile(HttpSession session, Model model) {
        User currentUser = (session != null) ? (User) session.getAttribute("account") : null;

        if (currentUser == null) {
            return "redirect:/login";
        }

        // Lấy dữ liệu mới nhất từ CSDL
        User user = userService.findById(currentUser.getId());
        model.addAttribute("user", user);

        return "web/profile";
    }

    // 2. Xử lý cập nhật hồ sơ & upload avatar
    @PostMapping({"", "/"})
    public String updateProfile(@RequestParam("fullname") String fullname,
                                @RequestParam("phone") String phone,
                                @RequestParam(value = "image", required = false) MultipartFile file,
                                HttpSession session,
                                Model model) {
        User currentUser = (session != null) ? (User) session.getAttribute("account") : null;

        if (currentUser == null) {
            return "redirect:/login";
        }

        // Server-side validation
        if (fullname == null || fullname.trim().length() < 2) {
            model.addAttribute("error", "Họ và tên không được để trống và phải có ít nhất 2 ký tự!");
            model.addAttribute("user", currentUser);
            return "web/profile";
        }

        if (phone == null || !phone.matches("0[0-9]{9}")) {
            model.addAttribute("error", "Số điện thoại phải gồm 10 chữ số và bắt đầu bằng số 0!");
            model.addAttribute("user", currentUser);
            return "web/profile";
        }

        User user = userService.findById(currentUser.getId());
        user.setFullname(fullname.trim());
        user.setPhone(phone.trim());

        // Xử lý upload ảnh đại diện
        try {
            if (file != null && !file.isEmpty() && file.getOriginalFilename() != null) {
                File dir = new File(uploadDir);
                if (!dir.exists()) {
                    dir.mkdirs();
                }

                String submittedName = Paths.get(file.getOriginalFilename()).getFileName().toString();
                int dotIndex = submittedName.lastIndexOf(".");
                String ext = (dotIndex > 0) ? submittedName.substring(dotIndex + 1) : "png";
                String newFileName = "avatar_" + System.currentTimeMillis() + "." + ext;

                // Xóa ảnh đại diện cũ trên ổ đĩa nếu có
                String oldImage = user.getImages();
                if (oldImage != null && !oldImage.startsWith("http") && !"avatar.png".equals(oldImage)) {
                    deleteOldFile(uploadDir + File.separator + oldImage);
                }

                Path destination = Paths.get(uploadDir, newFileName);
                Files.copy(file.getInputStream(), destination, StandardCopyOption.REPLACE_EXISTING);

                user.setImages(newFileName);
                user.setAvatar(newFileName);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Cập nhật vào DB
        userService.update(user);

        // Cập nhật lại session để navbar/topbar hiển thị đúng
        session.setAttribute("account", user);

        model.addAttribute("user", user);
        model.addAttribute("message", "Cập nhật thông tin hồ sơ thành công!");
        return "web/profile";
    }

    private void deleteOldFile(String filePath) {
        try {
            Path path = Paths.get(filePath);
            Files.deleteIfExists(path);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}