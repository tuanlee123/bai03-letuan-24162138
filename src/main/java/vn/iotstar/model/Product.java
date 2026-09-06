package vn.iotstar.model;

import java.io.Serializable;
import java.util.Date;
import jakarta.persistence.*;

@Entity
@Table(name = "Products") // Khớp tên bảng
public class Product implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "product_id") // Sửa lại đúng tên cột trong CSDL
    private int productId;

    @Column(name = "product_name", columnDefinition = "NVARCHAR(255)") // Sửa thành product_name
    private String productName;

    @Column(name = "description", columnDefinition = "NVARCHAR(MAX)")
    private String description;

    @Column(name = "price")
    private double price;

    @Column(name = "image_url") // Sửa thành image_url
    private String imageUrl;

    @Temporal(TemporalType.DATE)
    @Column(name = "created_at") // Sửa thành created_at
    private Date createdAt;

    // Khóa ngoại nối sang categories khớp với câu lệnh INSERT của bạn
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "category_id") // Sửa thành category_id
    private Category category;

    // Getter và Setter giữ nguyên như cũ...
    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }

    public Category getCategory() { return category; }
    public void setCategory(Category category) { this.category = category; }
}