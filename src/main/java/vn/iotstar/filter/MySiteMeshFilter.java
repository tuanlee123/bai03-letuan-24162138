package vn.iotstar.filter;

import jakarta.servlet.DispatcherType;
import jakarta.servlet.annotation.WebFilter;
import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;
import org.sitemesh.DecoratorSelector;
import org.sitemesh.webapp.WebAppContext;
import org.sitemesh.content.Content;


public class MySiteMeshFilter extends ConfigurableSiteMeshFilter {

    @Override
    protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
        builder.setCustomDecoratorSelector(new DecoratorSelector<WebAppContext>() {
            @Override
            public String[] selectDecoratorPaths(Content content, WebAppContext context) {
                String path = context.getPath();

                // 1. Loại trừ ảnh, tài nguyên tĩnh, auth
                if (path.startsWith("/login") 
                        || path.startsWith("/register") 
                        || path.startsWith("/verify-otp") 
                        || path.startsWith("/forgot-password") 
                        || path.startsWith("/reset-password") 
                        || path.startsWith("/image") 
                        || path.startsWith("/assets/")
                        || path.contains("login.jsp")
                        || path.contains("register.jsp")) {
                    return new String[0];
                }

                // 2. Trang admin
                if (path.startsWith("/admin") || path.contains("/views/admin/")) {
                    return new String[] { "/views/layouts/admin.jsp" };
                }

                // 3. Trang người dùng
                return new String[] { "/views/layouts/web.jsp" };
            }
        });
    }
}