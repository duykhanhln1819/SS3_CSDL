-- Tạo bảng
CREATE TABLE PRODUCTS (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    OriginalPrice DECIMAL(18,2)
);

-- Thêm dữ liệu
INSERT INTO PRODUCTS VALUES
(1, 'iPhone 15', 'Electronics', 20000000),
(2, 'Samsung Refrigerator', 'Electronics', 15000000),
(3, 'Water Spinach', 'Food', 10000),
(4, 'Filtered Fresh Milk', 'Food', 28000);

-- Update an toàn
START TRANSACTION;

SELECT * FROM PRODUCTS WHERE Category = 'Electronics';

UPDATE PRODUCTS
SET OriginalPrice = OriginalPrice * 0.9
WHERE Category = 'Electronics';

SELECT * FROM PRODUCTS;

COMMIT;
-- hoặc dùng ROLLBACK nếu sai

-- 1. Phân tích logic: 2 lỗi nghiêm trọng
-- Dưới đây là nguyên nhân khiến cỗ máy nhập liệu không thể vận hành trơn tru:

-- Lỗi 1: Lỗi cú pháp (Syntax Error) ở dòng "Giao Hàng Nhanh"
-- Nguyên nhân: Trong câu lệnh VALUES ('Giao Hàng Nhanh, '0901234567');, bạn đã quên mất dấu nháy đơn kết thúc (') ngay sau chữ Giao Hàng Nhanh.

-- Cơ chế lỗi: SQL sẽ hiểu rằng toàn bộ đoạn văn bản từ sau dấu nháy mở cho đến hết dòng là một chuỗi văn bản dài vô tận. Khi không tìm thấy dấu đóng, nó sẽ báo "Syntax Error" vì câu lệnh chưa hoàn tất.

-- Lỗi 2: Dữ liệu bị trống (NULL) ở dòng "Viettel Post"
-- Nguyên nhân: Trong câu lệnh INSERT INTO SHIPPERS VALUES ('Viettel Post');, bạn đã không liệt kê danh sách cột và chỉ cung cấp 1 giá trị.

-- Cơ chế lỗi: Bảng SHIPPERS có cấu trúc gồm ShipperID, ShipperName và Phone.

-- Do ShipperID tự tăng (AUTO_INCREMENT), hệ thống cố gắng khớp giá trị 'Viettel Post' vào cột tiếp theo là ShipperName.

-- Tuy nhiên, vì bạn không cung cấp giá trị thứ hai, SQL sẽ mặc định để cột