package vn.iotstar.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpSession;
import vn.iotstar.model.CartItem;
import vn.iotstar.model.Product;
import vn.iotstar.service.IProductService;

@Controller
@RequestMapping("/cart")
public class CartController {

    @Autowired
    private IProductService productService;

    // 1. Hiển thị trang giỏ hàng
    @GetMapping({"", "/"})
    public String viewCart() {
        return "web/cart";
    }

    // 2. Thêm sản phẩm vào giỏ (hỗ trợ cả GET và POST từ form)
    @RequestMapping("/add")
    public String addToCart(@RequestParam("productId") int productId,
                            @RequestParam(name = "quantity", defaultValue = "1") int quantity,
                            HttpSession session) {
        if (quantity < 1) {
            quantity = 1;
        }

        @SuppressWarnings("unchecked")
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new HashMap<>();
        }

        if (cart.containsKey(productId)) {
            CartItem item = cart.get(productId);
            item.setQuantity(item.getQuantity() + quantity);
        } else {
            // Trường hợp findById trả về Optional<Product> hoặc Product trực tiếp
            Product product = null;
            try {
                Object res = productService.findById(productId);
                if (res instanceof java.util.Optional) {
                    product = ((java.util.Optional<Product>) res).orElse(null);
                } else if (res instanceof Product) {
                    product = (Product) res;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            if (product != null) {
                cart.put(productId, new CartItem(product, quantity));
            }
        }

        session.setAttribute("cart", cart);
        return "redirect:/cart";
    }

    // 3. Cập nhật số lượng (+ / - hoặc nhập ô input)
    @GetMapping("/update")
    public String updateCart(@RequestParam("productId") int productId,
                             @RequestParam(name = "action", required = false) String action,
                             @RequestParam(name = "quantity", required = false) Integer quantity,
                             HttpSession session) {
        @SuppressWarnings("unchecked")
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");

        if (cart != null && cart.containsKey(productId)) {
            CartItem item = cart.get(productId);

            if ("increase".equalsIgnoreCase(action)) {
                item.setQuantity(item.getQuantity() + 1);
            } else if ("decrease".equalsIgnoreCase(action)) {
                if (item.getQuantity() > 1) {
                    item.setQuantity(item.getQuantity() - 1);
                } else {
                    cart.remove(productId);
                }
            } else if (quantity != null) {
                if (quantity > 0) {
                    item.setQuantity(quantity);
                } else {
                    cart.remove(productId);
                }
            }
            session.setAttribute("cart", cart);
        }

        return "redirect:/cart";
    }

    // 4. Xóa 1 sản phẩm khỏi giỏ hàng
    @GetMapping("/remove")
    public String removeFromCart(@RequestParam("productId") int productId, HttpSession session) {
        @SuppressWarnings("unchecked")
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");

        if (cart != null) {
            cart.remove(productId);
            session.setAttribute("cart", cart);
        }

        return "redirect:/cart";
    }

    // 5. Xóa sạch toàn bộ giỏ hàng
    @GetMapping("/clear")
    public String clearCart(HttpSession session) {
        session.removeAttribute("cart");
        return "redirect:/cart";
    }
}