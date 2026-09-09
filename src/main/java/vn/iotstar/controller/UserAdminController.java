package vn.iotstar.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import vn.iotstar.model.User;
import vn.iotstar.service.IUserService;
import vn.iotstar.util.Constant;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class UserAdminController {

    @Autowired
    private IUserService userService;

    @Value("${app.upload.dir:" + Constant.DIR + "}")
    private String uploadDir;

    // 1. Danh sách & Tìm kiếm
    @GetMapping("/users")
    public String listUsers(@RequestParam(value = "keyword", required = false) String keyword, Model model) {
        List<User> list;
        if (keyword != null && !keyword.trim().isEmpty()) {
            list = userService.search(keyword.trim());
        } else {
            list = userService.findAll();
        }
        model.addAttribute("userList", list);
        model.addAttribute("keyword", keyword);
        return "admin/user-list";
    }

    // 2. Mở form thêm mới
    @GetMapping("/user/add")
    public String showAddForm() {
        return "admin/user-add";
    }

    // 3. Xử lý thêm mới
    @PostMapping(value = {"/user/insert", "/user/add"})
    public String insertUser(@RequestParam("username") String username,
                             @RequestParam("email") String email,
                             @RequestParam("fullname") String fullname,
                             @RequestParam("password") String password,
                             @RequestParam(value = "phone", required = false) String phone,
                             @RequestParam(value = "roleid", defaultValue = "2") int roleid,
                             @RequestParam(value = "image", required = false) MultipartFile file,
                             Model model) {

        // Kiểm tra trùng username hoặc email
        if (userService.checkExistUsername(username)) {
            model.addAttribute("error", "Tên đăng nhập đã tồn tại!");
            return "admin/user-add";
        }
        if (userService.checkExistEmail(email)) {
            model.addAttribute("error", "Email đã tồn tại trong hệ thống!");
            return "admin/user-add";
        }

        User user = new User();
        user.setUsername(username);
        user.setEmail(email);
        user.setFullname(fullname);
        user.setPassword(password);
        user.setPhone(phone);
        user.setRoleid(roleid);
        user.setCreatedDate(new Date());

        try {
            if (file != null && !file.isEmpty() && file.getOriginalFilename() != null) {
                File dir = new File(uploadDir);
                if (!dir.exists()) dir.mkdirs();

                String originalFileName = Paths.get(file.getOriginalFilename()).getFileName().toString();
                String ext = "";
                int dotIndex = originalFileName.lastIndexOf(".");
                if (dotIndex >= 0) {
                    ext = originalFileName.substring(dotIndex);
                }
                String newFileName = "user_" + System.currentTimeMillis() + ext;
                Path destination = Paths.get(uploadDir, newFileName);
                Files.copy(file.getInputStream(), destination, StandardCopyOption.REPLACE_EXISTING);

                user.setImages(newFileName);
                user.setAvatar(newFileName);
            } else {
                user.setImages("default_avatar.png");
                user.setAvatar("default_avatar.png");
            }
        } catch (Exception e) {
            e.printStackTrace();
            user.setImages("default_avatar.png");
            user.setAvatar("default_avatar.png");
        }

        userService.insert(user);
        return "redirect:/admin/users";
    }

    // 4. Mở form chỉnh sửa
    @GetMapping("/user/edit")
    public String showEditForm(@RequestParam("id") int id, Model model) {
        try {
            User user = userService.findById(id);
            if (user != null) {
                model.addAttribute("user", user);
                return "admin/user-edit";
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "redirect:/admin/users";
    }

    // 5. Xử lý cập nhật
    @PostMapping(value = {"/user/update", "/user/edit"})
    public String updateUser(@RequestParam("id") int id,
                             @RequestParam("email") String email,
                             @RequestParam("fullname") String fullname,
                             @RequestParam(value = "password", required = false) String password,
                             @RequestParam(value = "phone", required = false) String phone,
                             @RequestParam("roleid") int roleid,
                             @RequestParam(value = "image", required = false) MultipartFile file) {
        try {
            User user = userService.findById(id);
            if (user != null) {
                user.setEmail(email);
                user.setFullname(fullname);
                if (password != null && !password.trim().isEmpty()) {
                    user.setPassword(password.trim());
                }
                user.setPhone(phone);
                user.setRoleid(roleid);

                if (file != null && !file.isEmpty() && file.getOriginalFilename() != null) {
                    File dir = new File(uploadDir);
                    if (!dir.exists()) dir.mkdirs();

                    String originalFileName = Paths.get(file.getOriginalFilename()).getFileName().toString();
                    String ext = "";
                    int dotIndex = originalFileName.lastIndexOf(".");
                    if (dotIndex >= 0) {
                        ext = originalFileName.substring(dotIndex);
                    }
                    String newFileName = "user_" + System.currentTimeMillis() + ext;
                    Path destination = Paths.get(uploadDir, newFileName);

                    // Xóa file ảnh cũ nếu có
                    String oldImage = user.getImages();
                    if (oldImage != null && !oldImage.startsWith("http") && !"default_avatar.png".equals(oldImage)) {
                        deleteOldFile(uploadDir + File.separator + oldImage);
                    }

                    Files.copy(file.getInputStream(), destination, StandardCopyOption.REPLACE_EXISTING);

                    user.setImages(newFileName);
                    user.setAvatar(newFileName);
                }

                userService.update(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "redirect:/admin/users";
    }

    // 6. Xóa người dùng
    @GetMapping("/user/delete")
    public String deleteUser(@RequestParam("id") int id) {
        try {
            User user = userService.findById(id);
            if (user != null) {
                String oldImage = user.getImages();
                if (oldImage != null && !oldImage.startsWith("http") && !"default_avatar.png".equals(oldImage)) {
                    deleteOldFile(uploadDir + File.separator + oldImage);
                }
                userService.delete(id);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "redirect:/admin/users";
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