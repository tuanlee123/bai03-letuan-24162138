package vn.iotstar.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.model.Product;
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
        String action = req.getServletPath();

        switch (action) {
            case "/home":
                try {
                    List<Product> top10 = productService.findTop10Latest();
                    req.setAttribute("top10", top10);
                } catch (Exception e) {
                    e.printStackTrace(); // In lỗi ra console nếu kết nối DB chết
                }
                req.getRequestDispatcher("/views/web/home.jsp").forward(req, resp);
                break;

            case "/product/detail":
                try {
                    int id = Integer.parseInt(req.getParameter("id"));
                    Product product = productService.findById(id);
                    if (product != null) {
                        req.setAttribute("p", product);
                        req.getRequestDispatcher("/views/web/product-detail.jsp").forward(req, resp);
                    } else {
                        resp.sendRedirect(req.getContextPath() + "/product");
                    }
                } catch (Exception e) {
                    resp.sendRedirect(req.getContextPath() + "/product");
                }
                break;

            case "/product":
                String pageStr = req.getParameter("page");
                int page = 1;
                try {
                    if (pageStr != null && !pageStr.isEmpty()) {
                        page = Integer.parseInt(pageStr);
                        if (page < 1) page = 1;
                    }
                } catch (NumberFormatException e) {
                    page = 1;
                }
                
                int pageSize = 6;
                List<Product> list = productService.findAll(page - 1, pageSize);
                int totalProducts = productService.count();
                int endPage = totalProducts / pageSize;
                if (totalProducts % pageSize != 0) {
                    endPage++;
                }

                req.setAttribute("listprod", list);
                req.setAttribute("endPage", endPage);
                req.setAttribute("tag", page);
                req.getRequestDispatcher("/views/web/product.jsp").forward(req, resp);
                break;

            default:
                resp.sendRedirect(req.getContextPath() + "/home");
                break;
        }
    }
}