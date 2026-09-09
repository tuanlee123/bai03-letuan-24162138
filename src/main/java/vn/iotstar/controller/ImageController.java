package vn.iotstar.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import vn.iotstar.util.Constant;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;

@Controller
public class ImageController {

    @Value("${app.upload.dir:" + Constant.DIR + "}")
    private String uploadDir;

    @GetMapping("/image")
    @ResponseBody
    public ResponseEntity<Resource> getImage(@RequestParam(name = "fname", required = false) String fileName) {
        if (fileName == null || fileName.trim().isEmpty()) {
            fileName = "default_avatar.png";
        }

        File file = new File(uploadDir, fileName);

        // Nếu file yêu cầu không có, tìm fallback
        if (!file.exists()) {
            file = new File(uploadDir, "default_avatar.png");
            if (!file.exists()) {
                file = new File(uploadDir, "default_cate.png");
            }
        }

        if (!file.exists()) {
            return ResponseEntity.notFound().build();
        }

        Resource resource = new FileSystemResource(file);

        // Tự động nhận diện định dạng MIME (image/png, image/jpeg, ...)
        String mimeType;
        try {
            mimeType = Files.probeContentType(file.toPath());
        } catch (IOException e) {
            mimeType = null;
        }

        MediaType mediaType = (mimeType != null) ? MediaType.parseMediaType(mimeType) : MediaType.IMAGE_JPEG;

        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=\"" + file.getName() + "\"")
                .contentType(mediaType)
                .body(resource);
    }
}