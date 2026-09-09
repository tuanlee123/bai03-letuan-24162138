package vn.iotstar.controller;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import vn.iotstar.model.Category;
import vn.iotstar.model.Product;
import vn.iotstar.service.ICategoryService;
import vn.iotstar.service.IProductService;

@Controller
public class WebController {

    @Autowired
    private IProductService productService;

    @Autowired
    private ICategoryService categoryService;

    @GetMapping({"", "/", "/home", "/trang-chu"})
    public String index(Model model) {
        try {
            // 1. Lấy toàn bộ danh sách sản phẩm từ DB
            List<Product> allProducts = productService.findAll();

            // 2. Lấy 8 sản phẩm mới nhất cho trang chủ
            List<Product> latestProducts = null;
            if (allProducts != null && !allProducts.isEmpty()) {
                latestProducts = allProducts.stream()
                        .sorted((p1, p2) -> Integer.compare(p2.getProductId(), p1.getProductId()))
                        .limit(8)
                        .collect(Collectors.toList());
            }

            // 3. Lấy danh sách danh mục hoạt động (status = 1)
            List<Category> allCategories = categoryService.findAll();
            List<Category> activeCategories = null;
            if (allCategories != null && !allCategories.isEmpty()) {
                activeCategories = allCategories.stream()
                        .filter(c -> c.getStatus() == 1)
                        .collect(Collectors.toList());
            }

            // 4. Đặt các biến vào Model
            model.addAttribute("latestProducts", latestProducts != null ? latestProducts : allProducts);
            model.addAttribute("listproduct", allProducts);
            model.addAttribute("listcate", activeCategories != null ? activeCategories : allCategories);
            model.addAttribute("categories", activeCategories != null ? activeCategories : allCategories);

            // Nạp views/index.jsp
            return "index";

        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/login";
        }
    }
}