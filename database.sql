-- 1. Sử dụng đúng database của dự án
USE ShoppingServiceMVC;
GO

-- 2. Thêm tài khoản mẫu (nếu chưa có)
-- roleid = 1: Admin, roleid = 2: User
IF NOT EXISTS (SELECT * FROM [User] WHERE username = 'admin')
BEGIN
    INSERT INTO [User] (email, username, fullname, password, roleid, phone, createdDate)
    VALUES ('admin@gmail.com', 'admin', N'Nguyễn Hữu Trung', '123', 1, '0908617108', GETDATE());
    ('user@gmail.com', 'user1', N'Trần Văn A', '123', NULL, 3, '0901234567', GETDATE());
END
GO

-- 3. Thêm danh mục mẫu (chuẩn tên cột theo Hibernate Entity Category)
IF NOT EXISTS (SELECT * FROM categories WHERE categoryname = N'Điện thoại')
BEGIN
    INSERT INTO categories (categoryname, images, status) 
    VALUES 
    (N'Điện thoại', 'phone.png', 1),
    (N'Laptop', 'laptop.png', 1),
    (N'Phụ kiện', 'accessory.png', 1);
END
GO

-- 4. Thêm 7 sản phẩm mẫu để test phân trang 6 sp/trang
-- Sử dụng category_id tương ứng với các danh mục vừa tạo
INSERT INTO Products (product_name, price, description, image_url, category_id, created_at) 
VALUES 
(N'iPhone 15 Pro Max', 30000000, N'Điện thoại Apple cao cấp nhất hiện nay', 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=500', 1, GETDATE()),
(N'Samsung Galaxy S24 Ultra', 28000000, N'Flagship Samsung tích hợp Galaxy AI', 'https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?w=500', 1, GETDATE()),
(N'MacBook Air M2', 24000000, N'Laptop mỏng nhẹ, pin cực trâu', 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=500', 2, GETDATE()),
(N'Dell XPS 13', 26000000, N'Màn hình vô cực, chuẩn doanh nhân', 'https://images.unsplash.com/photo-1593642632823-8f785ba67e45?w=500', 2, GETDATE()),
(N'Asus ROG Zephyrus', 35000000, N'Cỗ máy Gaming đồ họa đỉnh cao', 'https://images.unsplash.com/photo-1603302576837-37561b2e2302?w=500', 2, GETDATE()),
(N'Xiaomi 14 Pro', 18000000, N'Ống kính Leica sắc nét', 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=500', 1, GETDATE()),
(N'iPad Air 5 M1', 15000000, N'Tablet mạnh mẽ cho sáng tạo nội dung', 'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=500', 3, GETDATE());
GO