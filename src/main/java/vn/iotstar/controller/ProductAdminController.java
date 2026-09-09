package vn.iotstar.controller;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import vn.iotstar.model.Category;
import vn.iotstar.model.Product;
import vn.iotstar.service.ICategoryService;
import vn.iotstar.service.IProductService;
import vn.iotstar.util.Constant;

@Controller
@RequestMapping("/admin")
public class ProductAdminController {

    @Autowired
    private IProductService productService;

    @Autowired
    private ICategoryService categoryService;

    @Value("${app.upload.dir:" + Constant.DIR + "}")
    private String uploadDir;

    // 1. Danh sách sản phẩm
    @GetMapping("/products")
    public String listProducts(Model model) {
        List<Product> list = productService.findAll();
        List<Category> listCate = categoryService.findAll();
        model.addAttribute("listprod", list);
        model.addAttribute("listcate", listCate);
        return "admin/product-list";
    }

    // 2. Mở form thêm sản phẩm
    @GetMapping("/product/add")
    public String showAddForm(Model model) {
        List<Category> listCate = categoryService.findAll();
        model.addAttribute("listcate", listCate);
        return "admin/product-add";
    }

    // 3. Xử lý thêm sản phẩm
    @PostMapping(value = {"/product/insert", "/product/add"})
    public String insertProduct(@RequestParam("productName") String productName,
                                @RequestParam(value = "description", required = false) String description,
                                @RequestParam("price") double price,
                                @RequestParam("categoryId") int categoryId,
                                @RequestParam(value = "image", required = false) MultipartFile file) {
        try {
            Product product = new Product();
            product.setProductName(productName);
            product.setDescription(description);
            product.setPrice(price);

            Category category = categoryService.findById(categoryId);
            product.setCategory(category);

            // Xử lý upload ảnh
            if (file != null && !file.isEmpty() && file.getOriginalFilename() != null) {
                File dir = new File(uploadDir);
                if (!dir.exists()) {
                    dir.mkdirs();
                }

                String originalFileName = Paths.get(file.getOriginalFilename()).getFileName().toString();
                String ext = "";
                int dotIndex = originalFileName.lastIndexOf(".");
                if (dotIndex >= 0) {
                    ext = originalFileName.substring(dotIndex);
                }
                String newFileName = "prod_" + System.currentTimeMillis() + ext;
                Path destination = Paths.get(uploadDir, newFileName);
                Files.copy(file.getInputStream(), destination, StandardCopyOption.REPLACE_EXISTING);
                product.setImageUrl(newFileName);
            } else {
                product.setImageUrl("default.png");
            }

            productService.insert(product);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "redirect:/admin/products";
    }

    // 4. Mở form sửa sản phẩm
    @GetMapping("/product/edit")
    public String showEditForm(@RequestParam("id") int id, Model model) {
        try {
            Product product = productService.findById(id);
            List<Category> listCate = categoryService.findAll();

            if (product != null) {
                model.addAttribute("p", product);
                model.addAttribute("listCate", listCate);
                return "admin/product-edit";
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "redirect:/admin/products";
    }

    // 5. Xử lý cập nhật sản phẩm
    @PostMapping("/product/edit")
    public String updateProduct(@RequestParam("productId") int productId,
                                @RequestParam("productName") String productName,
                                @RequestParam(value = "description", required = false) String description,
                                @RequestParam("price") double price,
                                @RequestParam("categoryId") int categoryId,
                                @RequestParam(value = "oldImage", required = false) String oldImage,
                                @RequestParam(value = "image", required = false) MultipartFile file) {
        try {
            Product product = productService.findById(productId);
            if (product != null) {
                product.setProductName(productName);
                product.setDescription(description);
                product.setPrice(price);

                Category category = categoryService.findById(categoryId);
                product.setCategory(category);

                // Nếu có upload ảnh mới thì lưu ảnh mới, không thì giữ ảnh cũ
                if (file != null && !file.isEmpty() && file.getOriginalFilename() != null) {
                    File dir = new File(uploadDir);
                    if (!dir.exists()) {
                        dir.mkdirs();
                    }

                    String originalFileName = Paths.get(file.getOriginalFilename()).getFileName().toString();
                    String ext = "";
                    int dotIndex = originalFileName.lastIndexOf(".");
                    if (dotIndex >= 0) {
                        ext = originalFileName.substring(dotIndex);
                    }
                    String newFileName = "prod_" + System.currentTimeMillis() + ext;
                    Path destination = Paths.get(uploadDir, newFileName);
                    Files.copy(file.getInputStream(), destination, StandardCopyOption.REPLACE_EXISTING);
                    product.setImageUrl(newFileName);
                } else {
                    product.setImageUrl(oldImage != null && !oldImage.isEmpty() ? oldImage : "default.png");
                }

                productService.update(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "redirect:/admin/products";
    }

    // 6. Xóa sản phẩm
    @GetMapping("/product/delete")
    public String deleteProduct(@RequestParam("id") int id) {
        try {
            productService.delete(id);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "redirect:/admin/products";
    }
}