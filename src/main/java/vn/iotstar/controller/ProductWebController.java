package vn.iotstar.controller;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import vn.iotstar.model.Category;
import vn.iotstar.model.Product;
import vn.iotstar.service.ICategoryService;
import vn.iotstar.service.IProductService;

@Controller
@RequestMapping("/product")
public class ProductWebController {

    @Autowired
    private IProductService productService;

    @Autowired
    private ICategoryService categoryService;

    // 1. Danh sách sản phẩm kèm bộ lọc (/product)
    @GetMapping({"", "/"})
    public String listProducts(@RequestParam(name = "keyword", required = false) String keyword,
                               @RequestParam(name = "categoryId", required = false) Integer categoryId,
                               @RequestParam(name = "minPrice", required = false) Double minPrice,
                               @RequestParam(name = "maxPrice", required = false) Double maxPrice,
                               Model model) {
        try {
            List<Product> listProduct = productService.findAll();

            if (listProduct != null) {
                // Lọc theo danh mục nếu có chọn
                if (categoryId != null) {
                    listProduct = listProduct.stream()
                            .filter(p -> p.getCategory() != null && p.getCategory().getCategoryId() == categoryId)
                            .collect(Collectors.toList());
                }

                // Lọc theo từ khóa tìm kiếm nếu có nhập
                if (keyword != null && !keyword.trim().isEmpty()) {
                    String kwLower = keyword.trim().toLowerCase();
                    listProduct = listProduct.stream()
                            .filter(p -> p.getProductName() != null 
                                    && p.getProductName().toLowerCase().contains(kwLower))
                            .collect(Collectors.toList());
                }

                // Lọc theo khoảng giá tối thiểu nếu có
                if (minPrice != null) {
                    listProduct = listProduct.stream()
                            .filter(p -> p.getPrice() >= minPrice)
                            .collect(Collectors.toList());
                }

                // Lọc theo khoảng giá tối đa nếu có
                if (maxPrice != null) {
                    listProduct = listProduct.stream()
                            .filter(p -> p.getPrice() <= maxPrice)
                            .collect(Collectors.toList());
                }
            }

            // Lấy danh sách danh mục để đổ vào sidebar lọc
            List<Category> listCate = categoryService.findAll();

            model.addAttribute("listproduct", listProduct);
            model.addAttribute("listcate", listCate);
            model.addAttribute("keyword", keyword);
            model.addAttribute("categoryId", categoryId);
            model.addAttribute("minPrice", minPrice);
            model.addAttribute("maxPrice", maxPrice);

            return "web/product-list";
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/home";
        }
    }

    // 2. Chi tiết sản phẩm (/product/detail?id=...)
    @GetMapping("/detail")
    public String productDetail(@RequestParam("id") int id, Model model) {
        try {
            Product product = productService.findById(id);
            if (product == null) {
                return "redirect:/product";
            }

            model.addAttribute("product", product);

            // Lấy 4 sản phẩm liên quan cùng danh mục
            if (product.getCategory() != null) {
                int catId = product.getCategory().getCategoryId();
                List<Product> allProds = productService.findAll();
                if (allProds != null) {
                    List<Product> related = allProds.stream()
                            .filter(p -> p.getCategory() != null 
                                    && p.getCategory().getCategoryId() == catId 
                                    && p.getProductId() != product.getProductId())
                            .limit(4)
                            .collect(Collectors.toList());
                    model.addAttribute("relatedProducts", related);
                }
            }

            return "web/product-detail";
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/product";
        }
    }
}