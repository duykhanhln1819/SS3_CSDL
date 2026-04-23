-- 1. Tạo bảng
CREATE TABLE CUSTOMERS (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    FullName VARCHAR(100),
    Email VARCHAR(100),
    City VARCHAR(50),
    LastPurchaseDate DATE,
    Status VARCHAR(20)
);

-- 2. Thêm dữ liệu
INSERT INTO CUSTOMERS (FullName, Email, City, LastPurchaseDate, Status) VALUES
('Nguyễn Văn A', 'anv@gmail.com', 'Hà Nội', '2025-05-20', 'Active'),
('Trần Thị B', 'btt@gmail.com', 'Hà Nội', '2026-02-10', 'Active'),
('Lê Văn C', NULL, 'Hà Nội', '2025-01-15', 'Active'),
('Phạm Minh D', 'dpm@gmail.com', 'Hà Nội', '2024-12-01', 'Locked'),
('Hoàng An E', 'eha@gmail.com', 'TP HCM', '2025-03-01', 'Active');

-- 3. Truy vấn
SELECT FullName, Email
FROM CUSTOMERS
WHERE City = 'Hà Nội'
  AND LastPurchaseDate <= '2026-04-01'
  AND Email IS NOT NULL
  AND Status = 'Active';
  
--   1. Phân tích bài toán (I/O)
-- Input (Dữ liệu đầu vào): Quét dữ liệu từ bảng CUSTOMERS.

-- Output (Dữ liệu đầu ra): Chỉ lấy 2 cột thông tin là FullName và Email.

-- Tại sao SELECT * là sai lầm "nghẽn cổ chai"?
-- Dư thừa băng thông: Bảng có hàng chục cột (Địa chỉ, Ngày sinh, Giới tính...), việc dùng * bắt Database phải đọc và truyền tải hàng triệu dữ liệu rác qua mạng. Nếu mỗi dòng dư 1KB, 1 triệu dòng sẽ dư tới 1GB dữ liệu truyền tải vô ích.

-- Tốn RAM/CPU: Hệ thống gửi mail tự động chỉ cần Tên và Email. Nếu bạn "nhồi" thêm hàng chục cột khác, bộ nhớ của ứng dụng gửi mail sẽ bị quá tải (Crash) ngay lập tức khi nạp danh sách.

-- Vô hiệu hóa Index: Quét toàn bộ các cột thường khiến Database phải đọc dữ liệu trực tiếp từ ổ cứng (Disk Scan) thay vì sử dụng bộ chỉ mục (Index) trên bộ nhớ RAM, làm tốc độ truy vấn chậm đi hàng chục lần.