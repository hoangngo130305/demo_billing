HƯỚNG DẪN CÀI ĐẶT VÀ CHẠY HỆ THỐNG NẠP TIỀN PAYOS CHO SEMS
Phiên bản: 1.0 Ngày viết: 28/03/2026 Mục đích: Hướng dẫn lập trình viên cài đặt, cấu hình và test đầy đủ luồng nạp tiền qua PayOS (tạo QR → thanh toán → webhook tự động cập nhật trạng thái).
________________________________________
1. Yêu cầu hệ thống
•	Máy tính Windows
•	Python 3.8 trở lên
•	Visual Studio Code (khuyến nghị)
•	Tài khoản PayOS đã xác thực và có Kênh thanh toán
•	3 thông tin quan trọng từ PayOS:
o	PAYOS_CLIENT_ID
o	PAYOS_API_KEY
o	PAYOS_CHECKSUM_KEY
________________________________________
2. Cài đặt Ngrok
1.	Truy cập website: https://ngrok.com/download
2.	Tải phiên bản Windows 64-bit
3.	Giải nén file zip → được file ngrok.exe
4.	Copy file ngrok.exe vào thư mục dự án (ví dụ: E:\payos)
Lấy Authtoken:
1.	Truy cập: https://dashboard.ngrok.com/signup
2.	Đăng ký bằng Google hoặc GitHub
3.	Đăng nhập → vào Your Authtoken
4.	Copy chuỗi Authtoken
Cài Authtoken: Mở PowerShell tại thư mục dự án và chạy lệnh:
PowerShell
.\ngrok config add-authtoken [Dán chuỗi Authtoken vào đây]
________________________________________
3. Cấu hình file .env
Tạo file .env trong thư mục dự án với nội dung sau:
dotenv
PAYOS_CLIENT_ID=89345a06-9ea8-4499-8947-9ae6119951a9
PAYOS_API_KEY=5af5bccc-b585-4d01-bd4f-e44cd6bxxxxxxxx
PAYOS_CHECKSUM_KEY=1a3437cbeaa61497280a5bed5c683fe56ac5552f9ad14e8c1b7d9axxxx

RETURN_URL=http://localhost:5500/success.html
CANCEL_URL=http://localhost:5500/nap-tien.html
Lưu ý: Không để khoảng trắng sau dấu =.
________________________________________
4. Cài đặt thư viện Python
Mở PowerShell trong thư mục dự án và chạy:
PowerShell
pip install Flask Flask-CORS payos python-dotenv
Hoặc nếu có file requirements.txt:
PowerShell
pip install -r requirements.txt
________________________________________
5. Các file cần có trong dự án
•	app.py (Backend Flask)
•	nap-tien.html (Frontend)
•	.env
•	ngrok.exe
•	seams_payments.db (sẽ tự tạo)
________________________________________
6. Quy trình chạy chương trình (3 bước song song)
Bạn cần mở 3 cửa sổ PowerShell / Terminal cùng lúc.
Cửa sổ 1: Chạy Ngrok
PowerShell
.\ngrok http 5000
→ Copy địa chỉ HTTPS (ví dụ: https://humoursome-phonogramically-beatris.ngrok-free.dev)
Cửa sổ 2: Chạy Backend (Python)
PowerShell
python app.py
Backend chạy tại: http://localhost:5000
Cửa sổ 3: Chạy Frontend
1.	Mở Visual Studio Code
2.	Mở file nap-tien.html
3.	Right-click vào nội dung file → chọn "Open with Live Server"
4.	Trình duyệt tự mở tại: http://127.0.0.1:5500/nap-tien.html
________________________________________
7. Cấu hình Webhook trên PayOS
1.	Đăng nhập my.payos.vn
2.	Chọn Kênh thanh toán
3.	Tìm mục Webhook URL
4.	Dán địa chỉ sau:
Text
https://humoursome-phonogramically-beatris.ngrok-free.dev/api/webhook/payos 
https://[your-ngrok-url].ngrok-free.dev/api/webhook/payos
(Thay [your-ngrok-url] bằng URL thực tế từ ngrok)
5.	Nhấn Lưu hoặc Xác nhận
PayOS sẽ tự động gửi request test. Nếu thành công, webhook đã được kích hoạt.
________________________________________
8. Cách test luồng nạp tiền
1.	Giữ Ngrok và Backend đang chạy
2.	Mở nap-tien.html bằng Live Server
3.	Nhập số tiền (ví dụ: 50000)
4.	Nhấn nút "Tạo mã QR thanh toán"
5.	Mở ứng dụng ngân hàng trên điện thoại → quét mã QR → hoàn tất thanh toán
6.	Quan sát:
o	Terminal chạy python app.py: sẽ hiện thông báo thành công
o	Trang web: sau vài giây sẽ hiển thị "NẠP TIỀN THÀNH CÔNG"
________________________________________
9. Lưu ý quan trọng
•	Mỗi lần chạy lại ngrok sẽ sinh ra URL mới → phải cập nhật lại Webhook URL trên PayOS.
•	Không tắt ngrok và backend khi đang test.
•	Nên test với số tiền nhỏ (10.000 – 100.000 VND).
•	Khi deploy lên server thật (VPS, Heroku, Railway…), sẽ không cần ngrok nữa.
•	Đảm bảo user_id được truyền đúng khi tạo giao dịch để hệ thống xác định chính xác người nạp tiền.
________________________________________
10. Khắc phục lỗi thường gặp
•	Ngrok không nhận lệnh: Dùng .\ngrok http 5000
•	Webhook không hợp lệ: Kiểm tra backend có chạy không và URL webhook có đúng không.
•	Signature không hợp lệ: Kiểm tra PAYOS_CHECKSUM_KEY trong .env có đúng không.
•	Trang web không load: Mở nap-tien.html bằng Live Server, không mở trực tiếp file.

