# TAI LIEU HE THONG NAP TIEN & THANH TOAN - SEMS (DJANGO)

**Phien ban:** 2.0  
**Ngay cap nhat:** 16/04/2026  
**Muc dich:** Tai lieu van hanh he thong thanh toan PayOS voi backend Django, MySQL, frontend nap-tien.html.

---

## MUC LUC

1. [Tong quan he thong](#1-tong-quan-he-thong)
2. [Yeu cau he thong](#2-yeu-cau-he-thong)
3. [Cau hinh file .env](#3-cau-hinh-file-env)
4. [Cai dat thu vien](#4-cai-dat-thu-vien)
5. [Cau truc thu muc du an](#5-cau-truc-thu-muc-du-an)
6. [Khoi tao database MySQL](#6-khoi-tao-database-mysql)
7. [Quy trinh chay he thong](#7-quy-trinh-chay-he-thong)
8. [Cau hinh webhook tren PayOS](#8-cau-hinh-webhook-tren-payos)
9. [Test luong nap tien](#9-test-luong-nap-tien)
10. [Co so du lieu - Thiet ke bang](#10-co-so-du-lieu---thiet-ke-bang)
11. [Dac ta API](#11-dac-ta-api)
12. [Luong hoat dong](#12-luong-hoat-dong)
13. [Luu y quan trong](#13-luu-y-quan-trong)
14. [Khac phuc loi thuong gap](#14-khac-phuc-loi-thuong-gap)

---

## 1. Tong quan he thong

Kien truc hien tai:

- Frontend: `nap-tien.html` (Live Server, thuong la port 5500)
- Backend chinh: Django project `billing/` (port 8000)
- Database: MySQL (`billing`)
- Cong thanh toan: PayOS
- Tunnel webhook: ngrok (`ngrok.exe` tai thu muc goc du an)

Luu y:

- Luong Flask cu (`app.py`) khong phai backend chinh nua.
- Toan bo API frontend dang goi da chuyen sang `http://localhost:8000/api/...`.

---

## 2. Yeu cau he thong

| Thanh phan      | Yeu cau                                                  |
| --------------- | -------------------------------------------------------- |
| He dieu hanh    | Windows 10/11                                            |
| Python          | 3.10 tro len                                             |
| MySQL           | 8.x (khuyen nghi)                                        |
| Editor          | Visual Studio Code                                       |
| Tai khoan PayOS | Da xac thuc, da tao Kenh thanh toan                      |
| Thong tin PayOS | `PAYOS_CLIENT_ID`, `PAYOS_API_KEY`, `PAYOS_CHECKSUM_KEY` |

### 2.1 Cach lay 3 thong tin PayOS

1. Truy cap: https://my.payos.vn
2. Dang nhap tai khoan doanh nghiep da KYC.
3. Vao **Kenh thanh toan**.
4. Chon dung kenh thanh toan dang dung.
5. Lay 3 gia tri:
   - `Client ID` -> `PAYOS_CLIENT_ID`
   - `API Key` -> `PAYOS_API_KEY`
   - `Checksum Key` -> `PAYOS_CHECKSUM_KEY`

Luu y bao mat:

- Khong day key len GitHub.
- Khong gui key qua kenh cong khai.
- Neu nghi ngo lo key, rotate key ngay tren PayOS.

---

## 3. Cau hinh file `.env`

Dat file `.env` tai thu muc goc du an `seams_payments/.env`:

```dotenv
PAYOS_CLIENT_ID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
PAYOS_API_KEY=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
PAYOS_CHECKSUM_KEY=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

RETURN_URL=http://localhost:5500/success.html
CANCEL_URL=http://localhost:5500/nap-tien.html
```

Ghi chu:

- Khong de khoang trang quanh dau `=`.
- Sau khi sua `.env`, can restart Django server de nap lai bien moi truong.

---

## 4. Cai dat thu vien

### 4.1 Cai qua requirements.txt (khuyen nghi)

```powershell
pip install -r requirements.txt
```

### 4.2 Danh sach package chinh dang dung

- Django
- djangorestframework
- PyMySQL
- payos
- python-dotenv
- django-cors-headers

---

## 5. Cau truc thu muc du an

```text
seams_payments/
|-- .env
|-- nap-tien.html
|-- ngrok.exe
|-- requirements.txt
|-- billing/
|   |-- manage.py
|   |-- billing/
|   |   |-- settings.py
|   |   |-- urls.py
|   |   |-- __init__.py
|   |-- api/
|       |-- models.py
|       |-- views.py
|       |-- urls.py
|       |-- serializers.py
|       |-- admin.py
|       |-- migrations/
```

---

## 6. Khoi tao database MySQL

Tao DB (chay trong MySQL client):

```sql
CREATE DATABASE billing CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

Chay migrate:

```powershell
cd billing
../.venv/Scripts/python.exe manage.py migrate
```

Tao tai khoan admin:

```powershell
../.venv/Scripts/python.exe manage.py createsuperuser
```

---

## 7. Quy trinh chay he thong

Can 3 cua so terminal:

### Cua so 1 - Django backend

```powershell
cd billing
../.venv/Scripts/python.exe manage.py runserver 8000
```

Backend: `http://127.0.0.1:8000`

### Cua so 2 - ngrok

Neu dang o thu muc goc `seams_payments/`:

```powershell
./ngrok.exe http 8000
```

Neu dang o `seams_payments/billing/`:

```powershell
../ngrok.exe http 8000
```

Luu y quan trong:

- Lenh `./ngrok http 8000` hoac `./ngrok` se loi tren Windows vi file la `ngrok.exe`.
- Loi `Exit Code 127` thuong do goi sai duong dan/ngrok command.

### Cua so 3 - Frontend

1. Mo `nap-tien.html` bang Live Server trong VSCode.
2. URL thuong: `http://127.0.0.1:5500/nap-tien.html`

---

## 8. Cau hinh webhook tren PayOS

Moi lan chay lai ngrok se sinh URL moi, phai cap nhat lai webhook URL.

1. Dang nhap https://my.payos.vn
2. Vao **Kenh thanh toan**
3. Tim **Webhook URL**
4. Dat URL theo mau:

```text
https://<ngrok-domain>/api/webhook/payos
```

Vi du:

```text
https://abc123.ngrok-free.app/api/webhook/payos
```

5. Luu cau hinh.

Yeu cau:

- Backend Django phai dang chay truoc khi Save webhook.
- Webhook endpoint se tra HTTP 200 de PayOS xac nhan.

---

## 9. Test luong nap tien

1. Dam bao 3 thanh phan dang chay: Django, ngrok, Frontend.
2. Nhap so tien (vi du `50000`) tren `nap-tien.html`.
3. Nhan **Tao ma QR thanh toan**.
4. Quet QR va thanh toan bang app ngan hang.
5. Ket qua mong doi:
   - Backend log co thong tin webhook hoac poll-sync thanh cong.
   - `transactions.status` -> `SUCCESS`
   - `payments.status` -> `SUCCESS`
   - Co ban ghi moi trong `payment_logs`
   - Co ban ghi moi trong `wallet_history`
   - Frontend hien popup thanh toan thanh cong.

---

## 10. Co so du lieu - Thiet ke bang

He thong hien tai da co day du 6 bang trong app `api`:

### 10.1 `transactions`

- Muc dich: Trang thai giao dich nap tien tong quat.
- Trang thai: `PENDING | SUCCESS | FAILED | CANCELLED`

### 10.2 `payments`

- Muc dich: Chi tiet thanh toan (QR URL, mo ta, paid_at...).

### 10.3 `payment_logs`

- Muc dich: Luu log webhook/system de debug, doi soat, kiem toan.
- Nguon log hien co:
  - `WEBHOOK`: khi PayOS goi webhook
  - `SYSTEM`: khi tao payment, backfill, poll-sync success

### 10.4 `wallet_balances`

- Muc dich: So du hien tai tung user.

### 10.5 `wallet_history`

- Muc dich: Lich su bien dong vi.
- Kieu hien co: `TOP_UP | SPEND | REFUND | ADJUSTMENT`

### 10.6 `refunds`

- Muc dich: Quan ly yeu cau hoan tien.

### Tong hop trang thai bang

| STT | Bang              | Trang thai hien tai | Ghi chu |
| --- | ----------------- | ------------------- | ------- |
| 1   | `transactions`    | Da co               | Dang su dung |
| 2   | `payments`        | Da co               | Dang su dung |
| 3   | `payment_logs`    | Da co               | Dang su dung |
| 4   | `wallet_balances` | Da co               | Dang su dung |
| 5   | `wallet_history`  | Da co               | Dang su dung |
| 6   | `refunds`         | Da co               | Dang su dung |

---

## 11. Dac ta API

### 11.1 API nghiep vu thanh toan

#### POST `/api/create-payment`

Request:

```json
{
  "amount": 50000,
  "user_id": "user_123"
}
```

Response thanh cong:

```json
{
  "qrCode": "000201...",
  "checkoutUrl": "https://pay.payos.vn/web/...",
  "orderCode": 1713200000000
}
```

#### GET `/api/check-payment-status/{order_code}`

Response:

```json
{
  "orderCode": 1713200000000,
  "status": "SUCCESS",
  "amount": 50000,
  "message": "Thanh toan thanh cong"
}
```

Ghi chu:

- Neu webhook bi tre/miss, backend co co che poll-sync goi PayOS de cap nhat thanh cong.

#### POST `/api/webhook/payos`

Xu ly:

- Verify signature webhook
- Neu thanh toan thanh cong -> cap nhat transaction/payment
- Cong vi + ghi wallet_history
- Ghi payment_logs
- Tra ve HTTP 200

### 11.2 API CRUD (DRF Router)

- `GET/POST /api/transactions/`
- `GET/POST /api/payments/`
- `GET/POST /api/payment-logs/`
- `GET/POST /api/wallet-balances/`
- `GET/POST /api/wallet-history/`
- `GET/POST /api/refunds/`

### 11.3 API de xuat bo sung (chua lam)

- `GET /api/wallet/balance/{user_id}`
- `GET /api/wallet/history/{user_id}`

---

## 12. Luong hoat dong

```text
Nguoi dung
  -> Frontend nap-tien.html
  -> POST /api/create-payment
  -> Django tao payment link PayOS + luu PENDING
  -> Frontend hien QR + polling status
  -> Nguoi dung thanh toan qua app ngan hang
  -> PayOS goi /api/webhook/payos
  -> Django verify + cap nhat SUCCESS + cong vi + ghi logs
  -> Frontend nhan SUCCESS va hien popup
```

Fallback:

- Neu webhook khong vao kip, `GET /api/check-payment-status/{order_code}` se dong bo trang thai truc tiep tu PayOS.

---

## 13. Luu y quan trong

- Luon cap nhat webhook URL sau moi lan doi ngrok URL.
- Khong tat Django/ngrok trong luc test.
- Khong commit `.env`.
- Khong tin trang thai tu frontend, backend moi la nguon su that.
- Kiem tra `payment_logs` va `wallet_history` de doi soat.
- De production, dung domain HTTPS that, khong dung ngrok.

---

## 14. Khac phuc loi thuong gap

| Loi | Nguyen nhan | Cach xu ly |
| --- | ----------- | ---------- |
| `Exit Code 127` khi chay ngrok | Goi sai lenh/duong dan | Dung `./ngrok.exe http 8000` (tu root) hoac `../ngrok.exe http 8000` (tu billing) |
| Webhook khong vao backend | Chua cap nhat webhook URL moi | Cap nhat URL `https://<ngrok-domain>/api/webhook/payos` tren PayOS |
| Trang thai cu o `PENDING` | Webhook miss/cham | Kiem tra poll-sync endpoint va log Django |
| `Signature khong hop le` | Sai `PAYOS_CHECKSUM_KEY` | Kiem tra `.env`, restart backend |
| Frontend khong hien popup | API check-status khong tra `SUCCESS` | Kiem tra `transactions.status`, log poll-sync/webhook |
| CORS/host bi chan | Cau hinh host/chay sai port | Dam bao backend run `8000`, frontend goi dung API base |

---

_Tai lieu nay da duoc cap nhat theo codebase Django hien tai trong thu muc `billing/`._
