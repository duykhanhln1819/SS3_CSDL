-- 1. Tạo bảng
CREATE TABLE ORDERS (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerName VARCHAR(100),
    OrderDate DATETIME,
    TotalAmount DECIMAL(18,2),
    Status VARCHAR(20),
    IsDeleted TINYINT(1) DEFAULT 0
);

-- 2. Thêm dữ liệu
INSERT INTO ORDERS (CustomerName, OrderDate, TotalAmount, Status) VALUES
('Nguyễn Văn A', '2023-01-10', 500000, 'Completed'),
('Khách hàng vãng lai', '2023-02-15', 1200000, 'Canceled'),
('Trần Thị B', '2023-05-20', 300000, 'Canceled'),
('Lê Văn C', '2024-01-05', 850000, 'Completed');

-- 3. Soft delete (đánh dấu xóa, không xóa thật)
UPDATE ORDERS
SET IsDeleted = 1
WHERE Status = 'Canceled';

-- 4. Truy vấn
-- Đơn còn hoạt động
SELECT * FROM ORDERS
WHERE IsDeleted = 0;

-- Đơn bị hủy
SELECT * FROM ORDERS
WHERE Status = 'Canceled';

-- 1. Phân tích & Đề xuất Giải pháp
-- Giải pháp 1: Hard Delete (Xóa vật lý)
-- Sử dụng lệnh DELETE để gỡ bỏ vĩnh viễn các dòng dữ liệu có Status = 'Canceled' ra khỏi ổ cứng.

-- Cơ chế: Dữ liệu bị xóa sạch khỏi các tệp lưu trữ của Database.

-- Cú pháp: DELETE FROM ORDERS WHERE Status = 'Canceled';

-- Giải pháp 2: Soft Delete (Xóa logic)
-- Không xóa dòng dữ liệu mà dùng lệnh UPDATE để thay đổi trạng thái của một cột đánh dấu (Flag), ví dụ IsDeleted.

-- Cơ chế: Dữ liệu vẫn tồn tại trong bảng nhưng ứng dụng sẽ được lập trình để bỏ qua những dòng có IsDeleted = 1.

-- Cú pháp: UPDATE ORDERS SET IsDeleted = 1 WHERE Status = 'Canceled';