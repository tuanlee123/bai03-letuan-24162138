package vn.iotstar.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import vn.iotstar.model.Category;
import vn.iotstar.model.Product;
import vn.iotstar.service.ICategoryService;
import vn.iotstar.service.IProductService;
import vn.iotstar.service.impl.CategoryServiceImpl;
import vn.iotstar.service.impl.ProductServiceImpl;
import vn.iotstar.util.Constant;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

@WebServlet(urlPatterns = { "/admin/products", "/admin/product/add", "/admin/product/insert",
        "/admin/product/edit", "/admin/product/update", "/admin/product/delete" })
// Cấu hình Multipart theo yêu cầu của thầy
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 25)
public class ProductAdminController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private IProductService productService = new ProductServiceImpl();
    private ICategoryService categoryService = new CategoryServiceImpl();

    // Hàm lấy tên file từ Header (Theo slide của thầy)
    private String getFileName(Part part) {
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename"))
                return content.substring(content.indexOf("=") + 2, content.length() - 1).replace("\"", "");
        }
        return "default.file";
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURI();
        
        // Hiển thị danh sách sản phẩm
        if (url.contains("/admin/products")) {
            List<Product> list = productService.findAll();
            req.setAttribute("listprod", list);
            req.getRequestDispatcher("/views/admin/product-list.jsp").forward(req, resp);
        } 
        // Hiển thị trang Thêm mới
        else if (url.contains("/admin/product/add")) {
            List<Category> listCate = categoryService.findAll();
            req.setAttribute("listcate", listCate);
            req.getRequestDispatcher("/views/admin/product-add.jsp").forward(req, resp);
        } 
        // Hiển thị trang Sửa (Edit)
        else if (url.contains("/admin/product/edit")) {
            int id = Integer.parseInt(req.getParameter("id"));
            Product product = productService.findById(id);
            List<Category> listCate = categoryService.findAll(); // Cần danh sách Category để chọn lại
            
            req.setAttribute("p", product);
            req.setAttribute("listcate", listCate);
            req.getRequestDispatcher("/views/admin/product-edit.jsp").forward(req, resp);
        } 
        // Xóa sản phẩm
        else if (url.contains("/admin/product/delete")) {
            int id = Integer.parseInt(req.getParameter("id"));
            try {
                productService.delete(id); // Đã bọc try-catch để sửa lỗi
            } catch (Exception e) {
                e.printStackTrace();
            }
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String url = req.getRequestURI();

        // Xử lý Insert (Thêm mới)
        if (url.contains("/admin/product/insert")) {
            String productName = req.getParameter("productName");
            String description = req.getParameter("description");
            BigDecimal price = new BigDecimal(req.getParameter("price"));
            int categoryId = Integer.parseInt(req.getParameter("categoryId"));

            Product product = new Product();
            product.setProductName(productName);
            product.setDescription(description);
            product.setPrice(price);
            product.setCreatedAt(new Date());

            Category category = categoryService.findById(categoryId);
            product.setCategory(category);

            // Xử lý Upload file Multipart
            String uploadPath = Constant.DIR; 
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();

            try {
                Part part = req.getPart("image");
                if (part != null && part.getSize() > 0) {
                    String fileName = getFileName(part);
                    String ext = fileName.substring(fileName.lastIndexOf("."));
                    String newFileName = System.currentTimeMillis() + ext;
                    
                    part.write(uploadPath + File.separator + newFileName);
                    product.setImageUrl(newFileName);
                } else {
                    product.setImageUrl("default.png");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            productService.insert(product);
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        }
        
        // Xử lý Update (Cập nhật)
        else if (url.contains("/admin/product/update")) {
            int productId = Integer.parseInt(req.getParameter("productId"));
            String productName = req.getParameter("productName");
            String description = req.getParameter("description");
            BigDecimal price = new BigDecimal(req.getParameter("price"));
            int categoryId = Integer.parseInt(req.getParameter("categoryId"));

            // Lấy product cũ từ Database lên để giữ lại ngày tạo và ảnh cũ (nếu không chọn ảnh mới)
            Product product = productService.findById(productId);
            product.setProductName(productName);
            product.setDescription(description);
            product.setPrice(price);

            Category category = categoryService.findById(categoryId);
            product.setCategory(category);

            // Xử lý Upload file Multipart
            String uploadPath = Constant.DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();

            try {
                Part part = req.getPart("image");
                if (part != null && part.getSize() > 0) {
                    String fileName = getFileName(part);
                    String ext = fileName.substring(fileName.lastIndexOf("."));
                    String newFileName = System.currentTimeMillis() + ext;
                    
                    part.write(uploadPath + File.separator + newFileName);
                    product.setImageUrl(newFileName); // Cập nhật ảnh mới
                }
                // Nếu người dùng không chọn ảnh mới (size <= 0), hệ thống sẽ giữ nguyên imageUrl cũ
            } catch (Exception e) {
                e.printStackTrace();
            }

            productService.update(product);
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        }
    }
}