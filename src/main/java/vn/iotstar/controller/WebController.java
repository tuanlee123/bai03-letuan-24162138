package vn.iotstar.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.entity.Product;
import vn.iotstar.service.IProductService;
import vn.iotstar.service.impl.ProductServiceImpl;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/home", "/product", "/product/detail"})
public class WebController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private IProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURI();

        // 1. TRANG CHỦ: HIỂN THỊ TOP 10 SẢN PHẨM MỚI NHẤT
        if (url.contains("/home")) {
            List<Product> top10 = productService.findTop10Latest();
            req.setAttribute("top10", top10);
            req.getRequestDispatcher("/views/web/home.jsp").forward(req, resp);
        } 
        
        // 2. TRANG CHI TIẾT 1 SẢN PHẨM
        else if (url.contains("/product/detail")) {
            int id = Integer.parseInt(req.getParameter("id"));
            Product product = productService.findById(id);
            req.setAttribute("p", product);
            req.getRequestDispatcher("/views/web/product-detail.jsp").forward(req, resp);
        }
        
        // 3. TRANG DANH SÁCH: PHÂN TRANG 6 SẢN PHẨM / TRANG
        else if (url.contains("/product")) {
            String pageStr = req.getParameter("page");
            int page = 1; // Mặc định ở trang 1
            if (pageStr != null) {
                page = Integer.parseInt(pageStr);
            }
            int pageSize = 6; // Đề bài yêu cầu 6 SP / trang

            // JPA setFirstResult bắt đầu từ index 0, nên page phải trừ 1
            List<Product> list = productService.findAll(page - 1, pageSize);
            
            // Tính toán số lượng trang
            int totalProducts = productService.count();
            int endPage = totalProducts / pageSize;
            if (totalProducts % pageSize != 0) {
                endPage++;
            }

            req.setAttribute("listprod", list);
            req.setAttribute("endPage", endPage);
            req.setAttribute("tag", page); // Lưu lại trang hiện tại để làm sáng nút phân trang
            
            req.getRequestDispatcher("/views/web/product.jsp").forward(req, resp);
        }
    }
}