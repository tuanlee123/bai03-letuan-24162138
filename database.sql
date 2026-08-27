-- 1. Tạo Database (nếu chưa có)
CREATE DATABASE ShoppingServiceMVC;
GO

USE ShoppingServiceMVC;
GO

-- 2. Tạo bảng [User] phục vụ Đăng nhập, Phân quyền & Ghi nhớ Cookie/Session
IF OBJECT_ID('[User]', 'U') IS NOT NULL DROP TABLE [User];
GO

CREATE TABLE [User](
    [id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [email] NVARCHAR(255) NULL,
    [username] NVARCHAR(255) NOT NULL,
    [fullname] NVARCHAR(255) NULL,
    [password] NVARCHAR(255) NOT NULL,
    [avatar] NVARCHAR(255) NULL,
    [roleid] INT NOT NULL, -- 1: Admin, 2: Manager, 3: User
    [phone] NVARCHAR(50) NULL,
    [createdDate] DATE NULL
);
GO

-- 3. Tạo bảng [Category] phục vụ CRUD và Upload ảnh
IF OBJECT_ID('Category', 'U') IS NOT NULL DROP TABLE Category;
GO

CREATE TABLE Category(
    [cate_id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [cate_name] NVARCHAR(255) NOT NULL,
    [icons] NVARCHAR(255) NULL
);
GO

-- 4. Chèn dữ liệu mẫu cho bảng [User]
INSERT INTO [User]([email], [username], [fullname], [password], [avatar], [roleid], [phone], [createdDate])
VALUES 
('admin@gmail.com', 'admin', N'Nguyễn Hữu Trung', '123', NULL, 1, '0908617108', GETDATE()),
('user@gmail.com', 'user1', N'Trần Văn A', '123', NULL, 3, '0901234567', GETDATE());
GO

-- 5. Chèn dữ liệu mẫu cho bảng [Category]
INSERT INTO Category([cate_name], [icons])
VALUES 
(N'Quần Áo Nam', NULL),
(N'Quần Áo Nữ', NULL),
(N'Giày Dép', NULL);
GO