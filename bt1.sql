CREATE TABLE PRODUCTS (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    OriginalPrice DECIMAL(18,2)
);

INSERT INTO PRODUCTS (ProductID, ProductName, Category, OriginalPrice)
VALUES 
(1, 'iPhone 15', 'Electronics', 20000000),
(2, 'Samsung Refrigerator', 'Electronics', 15000000),
(3, 'Water Spinach', 'Food', 10000),
(4, 'Filtered Fresh Milk', 'Food', 28000);

-- Bước 0: Bắt đầu transaction
START TRANSACTION;

-- Bước 1: Xem trước dữ liệu sẽ bị ảnh hưởng
SELECT * 
FROM PRODUCTS 
WHERE Category = 'Electronics';

-- Bước 2: Update đúng đối tượng
UPDATE PRODUCTS 
SET OriginalPrice = OriginalPrice * 0.9
WHERE Category = 'Electronics';

-- Bước 3: Kiểm tra lại sau khi update
SELECT * 
FROM PRODUCTS;

-- Bước 4: Quyết định
-- Nếu đúng → lưu
COMMIT;

-- Nếu sai → rollback (chạy dòng này thay cho COMMIT)
-- ROLLBACK;


-- 1. Phân tích Logic: Tại sao lỗi này lại xảy ra?
-- Nguyên nhân nằm ở cấu trúc của lệnh UPDATE khi bị thiếu điều kiện lọc.

-- Lỗi nằm ở việc thiếu mệnh đề WHERE: Trong SQL, lệnh UPDATE nếu không có điều kiện WHERE, nó sẽ mặc định áp dụng lên tất cả các bản ghi (rows) hiện có trong bảng.

-- Hậu quả thực tế: Thay vì chỉ nhắm vào mặt hàng 'Electronics', câu lệnh của thực tập sinh đã nhân đơn giá của mọi thứ (từ thực phẩm như 'Rau muống' đến đồ điện tử) với 0.9.

-- Tại sao gọi là "lỗi đuổi việc"?: Vì trong các hệ thống thực tế với hàng triệu dòng dữ liệu, việc chạy một lệnh UPDATE toàn bộ mà không có bản sao lưu (backup) gần nhất có thể gây ra thiệt hại tài chính khổng lồ và mất rất nhiều thời gian để khôi phục (rollback) chính xác giá trị cũ cho từng mặt hàng.
