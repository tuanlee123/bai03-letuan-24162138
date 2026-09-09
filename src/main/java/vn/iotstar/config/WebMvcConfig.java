package vn.iotstar.config;

import java.io.File;
import org.apache.catalina.webresources.StandardRoot;
import org.springframework.boot.web.embedded.tomcat.TomcatServletWebServerFactory;
import org.springframework.boot.web.server.WebServerFactoryCustomizer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    // Ép Tomcat nhúng nhận thư mục webapp làm Document Root
    @Bean
    public WebServerFactoryCustomizer<TomcatServletWebServerFactory> staticResourceCustomizer() {
        return factory -> {
            File root = new File("src/main/webapp");
            if (root.exists()) {
                factory.setDocumentRoot(root);
            }
        };
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/static/**")
                .addResourceLocations("classpath:/static/");
        registry.addResourceHandler("/uploads/**")
                .addResourceLocations("file:C:/upload/");
    }
}