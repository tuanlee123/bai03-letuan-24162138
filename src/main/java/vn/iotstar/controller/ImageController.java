package vn.iotstar.controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.util.Constant;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

@WebServlet(urlPatterns = "/image")
public class ImageController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String fileName = req.getParameter("fname");
        if (fileName != null) {
            File file = new File(Constant.DIR + "/" + fileName);
            if (file.exists()) {
                try (FileInputStream fis = new FileInputStream(file)) {
                    resp.setContentType("image/jpeg");
                    fis.transferTo(resp.getOutputStream());
                }
            }
        }
    }
}