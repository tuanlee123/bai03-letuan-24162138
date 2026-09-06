package vn.iotstar.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.Date;
import java.util.List;

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

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 10,       // 10MB
    maxRequestSize = 1024 * 1024 * 50     // 50MB
)
@WebServlet(urlPatterns = {
    "/admin/products",
    "/admin/product/add",
    "/admin/product/insert",
    "/admin/product/edit",
    "/admin/product/delete"
})
public class ProductAdminController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private IProductService productService = new ProductServiceImpl();
    private ICategoryService categoryService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String action = req.getServletPath();

        if ("/admin/products".equals(action)) {
            List<Product> list = productService.findAll();
            List<Category> listCate = categoryService.findAll();
            req.setAttribute("listprod", list);
            req.setAttribute("listcate", listCate);
            req.getRequestDispatcher("/views/admin/product-list.jsp").forward(req, resp);

        } else if ("/admin/product/add".equals(action)) {
            List<Category> listCate = categoryService.findAll();
            req.setAttribute("listcate", listCate);
            req.getRequestDispatcher("/views/admin/product-add.jsp").forward(req, resp);

        } else if ("/admin/product/edit".equals(action)) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                Product product = productService.findById(id);
                List<Category> listCate = categoryService.findAll();

                if (product != null) {
                    req.setAttribute("p", product);
                    req.setAttribute("listCate", listCate);
                    req.getRequestDispatcher("/views/admin/product-edit.jsp").forward(req, resp);
                } else {
                    resp.sendRedirect(req.getContextPath() + "/admin/products");
                }
            } catch (Exception e) {
                e.printStackTrace();
                resp.sendRedirect(req.getContextPath() + "/admin/products");
            }

        } else if ("/admin/product/delete".equals(action)) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                productService.delete(id);
            } catch (Exception e) {
                e.printStackTrace();
            }
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String action = req.getServletPath();

        // Đảm bảo thư mục lưu trữ ảnh tồn tại
        String uploadPath = Constant.DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        if ("/admin/product/insert".equals(action) || "/admin/product/add".equals(action)) {
            try {
                String productName = req.getParameter("productName");
                String description = req.getParameter("description");
                double price = Double.parseDouble(req.getParameter("price"));
                int categoryId = Integer.parseInt(req.getParameter("categoryId"));

                Product product = new Product();
                product.setProductName(productName);
                product.setDescription(description);
                product.setPrice(price);

                Category category = categoryService.findById(categoryId);
                product.setCategory(category);

                // Xử lý upload ảnh
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

                productService.insert(product);
                resp.sendRedirect(req.getContextPath() + "/admin/products");

            } catch (Exception e) {
                e.printStackTrace();
                resp.sendRedirect(req.getContextPath() + "/admin/products");
            }

        } else if ("/admin/product/edit".equals(action)) {
            try {
                int productId = Integer.parseInt(req.getParameter("productId"));
                String productName = req.getParameter("productName");
                String description = req.getParameter("description");
                double price = Double.parseDouble(req.getParameter("price"));
                int categoryId = Integer.parseInt(req.getParameter("categoryId"));
                String oldImage = req.getParameter("oldImage");

                Product product = productService.findById(productId);
                if (product != null) {
                    product.setProductName(productName);
                    product.setDescription(description);
                    product.setPrice(price);

                    Category category = categoryService.findById(categoryId);
                    product.setCategory(category);

                    // Xử lý ảnh: nếu có up ảnh mới thì thay, không thì giữ ảnh cũ
                    Part part = req.getPart("image");
                    if (part != null && part.getSize() > 0) {
                        String fileName = getFileName(part);
                        String ext = fileName.substring(fileName.lastIndexOf("."));
                        String newFileName = System.currentTimeMillis() + ext;

                        part.write(uploadPath + File.separator + newFileName);
                        product.setImageUrl(newFileName);
                    } else {
                        product.setImageUrl(oldImage != null ? oldImage : "default.png");
                    }

                    productService.update(product);
                }
                resp.sendRedirect(req.getContextPath() + "/admin/products");

            } catch (Exception e) {
                e.printStackTrace();
                resp.sendRedirect(req.getContextPath() + "/admin/products");
            }
        }
    }

    // Phương thức trích xuất tên file từ HTTP Part Header
    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        for (String content : contentDisp.split(";")) {
            if (content.trim().startsWith("filename")) {
                String fileName = content.substring(content.indexOf("=") + 2, content.length() - 1);
                return Paths.get(fileName).getFileName().toString();
            }
        }
        return "default.png";
    }
}