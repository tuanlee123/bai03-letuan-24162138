package vn.iotstar.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import vn.iotstar.model.Category;
import vn.iotstar.service.ICategoryService;
import vn.iotstar.service.impl.CategoryServiceImpl;
import vn.iotstar.util.Constant;

import java.io.File;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {
    "/admin/categories",
    "/admin/category/add",
    "/admin/category/insert",
    "/admin/category/edit",
    "/admin/category/update",
    "/admin/category/delete"
})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 10,       // 10MB
    maxRequestSize = 1024 * 1024 * 25     // 25MB
)
public class CategoryController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private ICategoryService categoryService = new CategoryServiceImpl();

    private String getFileName(Part part) {
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf("=") + 2, content.length() - 1).replace("\"", "");
            }
        }
        return "default.file";
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html; charset=UTF-8");
        req.setCharacterEncoding("UTF-8");

        String action = req.getServletPath();

        switch (action) {
            case "/admin/categories":
                List<Category> list = categoryService.findAll();
                req.setAttribute("listcate", list);
                // Dùng include để SiteMesh 3 bọc trọn decorator layout admin.jsp
                req.getRequestDispatcher("/views/admin/categories.jsp").include(req, resp);
                break;

            case "/admin/category/add":
                req.getRequestDispatcher("/views/admin/category-add.jsp").include(req, resp);
                break;

            case "/admin/category/edit":
                try {
                    int id = Integer.parseInt(req.getParameter("id"));
                    Category category = categoryService.findById(id);
                    if (category != null) {
                        req.setAttribute("cate", category);
                        req.getRequestDispatcher("/views/admin/category-edit.jsp").include(req, resp);
                    } else {
                        resp.sendRedirect(req.getContextPath() + "/admin/categories");
                    }
                } catch (Exception e) {
                    resp.sendRedirect(req.getContextPath() + "/admin/categories");
                }
                break;

            case "/admin/category/delete":
                try {
                    int id = Integer.parseInt(req.getParameter("id"));
                    categoryService.delete(id);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                resp.sendRedirect(req.getContextPath() + "/admin/categories");
                break;

            default:
                resp.sendRedirect(req.getContextPath() + "/admin/categories");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String action = req.getServletPath();

        if ("/admin/category/insert".equals(action) || "/admin/category/add".equals(action)) {
            String categoryname = req.getParameter("categoryname");
            int status = 1;
            try {
                status = Integer.parseInt(req.getParameter("status"));
            } catch (Exception ignored) {}

            Category category = new Category();
            category.setCategoryname(categoryname);
            category.setStatus(status);

            // Xử lý upload icon/ảnh đại diện bằng Multipart
            String uploadPath = Constant.DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            try {
                Part part = req.getPart("image");
                if (part != null && part.getSize() > 0) {
                    String fileName = getFileName(part);
                    String ext = "";
                    int dotIndex = fileName.lastIndexOf(".");
                    if (dotIndex >= 0) {
                        ext = fileName.substring(dotIndex);
                    }
                    String newFileName = "cate_" + System.currentTimeMillis() + ext;
                    part.write(uploadPath + File.separator + newFileName);
                    category.setImages(newFileName);
                } else {
                    category.setImages("default_cate.png");
                }
            } catch (Exception e) {
                category.setImages("default_cate.png");
            }

            categoryService.insert(category);
            resp.sendRedirect(req.getContextPath() + "/admin/categories");

        } else if ("/admin/category/update".equals(action) || "/admin/category/edit".equals(action)) {
            try {
                int categoryId = Integer.parseInt(req.getParameter("categoryId"));
                String categoryname = req.getParameter("categoryname");
                int status = Integer.parseInt(req.getParameter("status"));

                Category category = categoryService.findById(categoryId);
                if (category != null) {
                    category.setCategoryname(categoryname);
                    category.setStatus(status);

                    String uploadPath = Constant.DIR;
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) uploadDir.mkdirs();

                    Part part = req.getPart("image");
                    if (part != null && part.getSize() > 0) {
                        String fileName = getFileName(part);
                        String ext = "";
                        int dotIndex = fileName.lastIndexOf(".");
                        if (dotIndex >= 0) {
                            ext = fileName.substring(dotIndex);
                        }
                        String newFileName = "cate_" + System.currentTimeMillis() + ext;
                        part.write(uploadPath + File.separator + newFileName);
                        category.setImages(newFileName);
                    }

                    categoryService.update(category);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            resp.sendRedirect(req.getContextPath() + "/admin/categories");
        }
    }
}