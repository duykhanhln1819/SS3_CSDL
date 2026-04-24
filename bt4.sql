CREATE TABLE ORDERS (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerName VARCHAR(100),
    OrderDate DATETIME,
    TotalAmount DECIMAL(18,2),
    Status VARCHAR(20),
    IsDeleted TINYINT(1) DEFAULT 0
);
INSERT INTO ORDERS (CustomerName, OrderDate, TotalAmount, Status) VALUES
('Nguyễn Văn A', '2023-01-10', 500000, 'Completed'),
('Khách hàng vãng lai', '2023-02-15', 1200000, 'Canceled'),
('Trần Thị B', '2023-05-20', 300000, 'Canceled'),
('Lê Văn C', '2024-01-05', 850000, 'Completed');

CREATE INDEX idx_isdeleted ON ORDERS(IsDeleted);

UPDATE ORDERS
SET IsDeleted = 1
WHERE Status = 'Canceled';

SELECT * FROM ORDERS
WHERE IsDeleted = 0;

SELECT * FROM ORDERS
WHERE IsDeleted = 1;

SELECT * FROM ORDERS
WHERE Status = 'Canceled' AND IsDeleted = 0;

-- 1. Hai giải pháp thao tác dữ liệu
-- 🔴 Hard Delete (Xóa vật lý)
-- Dùng DELETE
-- Dữ liệu bị xóa vĩnh viễn khỏi database
-- DELETE FROM ORDERS
-- WHERE Status = 'Canceled';
-- 🟡 Soft Delete (Xóa logic)
-- Dùng UPDATE
-- Không xóa, chỉ đánh dấu IsDeleted = 1
-- UPDATE ORDERS
-- SET IsDeleted = 1
-- WHERE Status = 'Canceled';

-- 2. Bảng so sánh chi tiết
-- Tiêu chí	Hard Delete	Soft Delete
-- 🧹 Giải phóng dung lượng	✅ Tốt (xóa thật khỏi ổ cứng)	❌ Không giảm dung lượng
-- ⚡ Tốc độ truy vấn	✅ Nhanh hơn (ít dữ liệu hơn)	❌ Chậm hơn (phải lọc IsDeleted)
-- 📜 Tính vẹn toàn lịch sử (kế toán, audit)	❌ Mất dữ liệu → không truy vết được	✅ Giữ đầy đủ lịch sử
-- 🔄 Khả năng khôi phục	❌ Không thể	✅ Có thể restore
-- 🧠 Độ phức tạp code	✅ Đơn giản	❌ Phức tạp hơn (luôn phải WHERE thêm)
-- 🔍 Phù hợp nghiệp vụ lớn (siêu thị, tài chính)	❌ Không phù hợp	✅ Rất phù hợp