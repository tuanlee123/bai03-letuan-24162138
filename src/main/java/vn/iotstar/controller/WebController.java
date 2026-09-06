package vn.iotstar.controller;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import vn.iotstar.model.Category;
import vn.iotstar.model.Product;
import vn.iotstar.service.ICategoryService;
import vn.iotstar.service.IProductService;
import vn.iotstar.service.impl.CategoryServiceImpl;
import vn.iotstar.service.impl.ProductServiceImpl;

@WebServlet(urlPatterns = {
    "/home",
    "/trang-chu"
})
public class WebController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private IProductService productService = new ProductServiceImpl();
    private ICategoryService categoryService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

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

            // 3. Lấy danh sách danh mục
            List<Category> allCategories = categoryService.findAll();
            List<Category> activeCategories = null;
            if (allCategories != null && !allCategories.isEmpty()) {
                activeCategories = allCategories.stream()
                        .filter(c -> c.getStatus() == 1)
                        .collect(Collectors.toList());
            }

            // 4. Đặt các biến vào request (cung cấp đa dạng tên biến để tránh lệch gọi ở JSP)
            req.setAttribute("latestProducts", latestProducts != null ? latestProducts : allProducts);
            req.setAttribute("listproduct", allProducts);
            req.setAttribute("listcate", activeCategories != null ? activeCategories : allCategories);
            req.setAttribute("categories", activeCategories != null ? activeCategories : allCategories);

            // 5. Forward chuẩn ra trang views/index.jsp
            req.getRequestDispatcher("/views/index.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().println("Loi tai trang chu: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        doGet(req, resp);
    }
}