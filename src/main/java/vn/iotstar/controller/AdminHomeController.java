package vn.iotstar.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class AdminHomeController {

    @GetMapping("/home")
    public String home() {
        // Tự động ghép với prefix (/views/) và suffix (.jsp) trong application.properties
        return "admin/home";
    }
}