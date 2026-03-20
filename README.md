# 🏢 Apartment Management System (AMS)

<h3 align="center">Hệ Thống Quản Lý Chung Cư Toàn Diện</h3>

<div align="center">

![Django](https://img.shields.io/badge/Django-4.2+-092E20?style=for-the-badge&logo=django&logoColor=white)
![Python](https://img.shields.io/badge/Python-3.11+-3776AB?style=for-the-badge&logo=python&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-8.0+-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![TailwindCSS](https://img.shields.io/badge/TailwindCSS-3.4+-06B6D4?style=for-the-badge&logo=tailwindcss&logoColor=white)


**Giải pháp quản lý chung cư chuyên nghiệp với đầy đủ tính năng: quản lý cư dân, phí dịch vụ, bảo trì, phương tiện, khách thăm, thông báo và báo cáo chi tiết.**

[🌐 Demo Online](#-demo-online) • [📖 Tài Liệu](#-tài-liệu) • [🚀 Cài Đặt](#-cài-đặt) • [📚 API](#-api-endpoints) 

</div>

---

## ✨ Tính Năng Nổi Bật

### 👥 Quản Lý Cư Dân
- ✅ CRUD cư dân đầy đủ (thêm, sửa, xóa, xem)
- ✅ Quản lý thông tin căn hộ, tầng, tòa nhà
- ✅ Tìm kiếm nâng cao, lọc và sắp xếp
- ✅ Xóa mềm (soft delete) hỗ trợ khôi phục
- ✅ Quản lý đơn vị/căn hộ chi tiết
- ✅ Theo dõi lịch sử cư dân

### 💳 Quản Lý Phí Dịch Vụ
- ✅ Tính toán và quán lý phí dịch vụ tự động
- ✅ Hỗ trợ nhiều loại phí (phí quản lý, nước, điện, vệ sinh, v.v.)
- ✅ Cấu hình phí theo tòa, tầng, căn hộ
- ✅ Lập lịch thanh toán phí tự động
- ✅ Theo dõi tình trạng nợ và quá hạn
- ✅ Cảnh báo nợ thế chấp
- ✅ Xuất báo cáo nợ chi tiết (Excel, PDF)

### 🔧 Quản Lý Bảo Trì & Sửa Chữa
- ✅ Quản lý yêu cầu bảo trì, sửa chữa
- ✅ Phân công công việc bảo dưỡng
- ✅ Trạng thái công việc chi tiết (Mới, Đang xử lý, Hoàn thành, Bị từ chối)
- ✅ Ghi chú, hình ảnh, chi phí bảo trì
- ✅ Lịch sử bảo trì thiết bị
- ✅ Thông báo tự động cho cư dân

### 🚗 Quản Lý Phương Tiện
- ✅ CRUD phương tiện gắn với cư dân
- ✅ Quản lý biển số xe, loại phương tiện
- ✅ Đăng ký phương tiện, ảnh, tài liệu
- ✅ Kiểm soát phương tiện trong khu vực
- ✅ Hạn chế loại phương tiện theo quy định

### 👥 Quản Lý Khách Thăm
- ✅ Ghi nhập khách thăm (tên, CCCD, mục đích)
- ✅ Xác định cư dân chủ nhà
- ✅ Ghi lại thời gian vào/ra
- ✅ Kiểm soát bảo mật khu vực
- ✅ Lịch sử khách thăm chi tiết

### 📢 Quản Lý Thông Báo & Tin Tức
- ✅ Tạo, chỉnh sửa, xóa thông báo, tin tức
- ✅ Phân loại thông báo (Thông báo chung, Khẩn cấp, Sự kiện, v.v.)
- ✅ Gửi thông báo tới từng cư dân hoặc toàn bộ
- ✅ Hỗ trợ hình ảnh, tệp đính kèm
- ✅ Thống kê lượt xem

### 📊 Báo Cáo & Thống Kê
- ✅ Báo cáo doanh thu, phí, nợ theo tháng/quý/năm
- ✅ Báo cáo bảo trì chi tiết
- ✅ Báo cáo cư dân, phương tiện
- ✅ Báo cáo khách thăm
- ✅ Xuất báo cáo Excel, PDF chuyên nghiệp
- ✅ Biểu đồ, thống kê trực quan

### 👨‍💼 Quản Lý Tài Khoản & Phân Quyền
- ✅ Phân quyền chi tiết (Admin, Quản lý, Thu ngân, Nhân viên)
- ✅ Quản lý tài khoản người dùng
- ✅ Thay đổi mật khẩu an toàn
- ✅ Thay đổi avatar, thông tin cá nhân
- ✅ Lịch sử đăng nhập, hoạt động
- ✅ Kiểm soát truy cập từng chức năng

### 🏠 Quản Lý Tòa Nhà & Căn Hộ
- ✅ Quản lý cấu trúc tòa nhà, tầng, phòng
- ✅ Cấu hình thông tin tòa nhà
- ✅ Quản lý loại căn hộ, diện tích
- ✅ Biểu đồ tình trạng căn hộ (Trống, Có người ở, Bảo mật)

---

## 🌐 Demo Online

**📍 Truy cập**: [http://103.216.118.156:8000/](http://103.216.118.156:8000/)

> 💡 **Tài khoản demo**: Xin vui lòng liên hệ quản trị viên để cấp tài khoản đăng nhập

---

## 🛠️ Công Nghệ (Tech Stack)

### Backend
| Công Nghệ | Phiên Bản | Mục Đích |
|-----------|----------|---------|
| **Django** | 4.2+ | Web Framework |
| **Python** | 3.11+ | Ngôn ngữ lập trình |
| **MySQL** | 8.0+ | Cơ sở dữ liệu |
| **mysqlclient** | - | MySQL Driver |
| **Gunicorn** | - | WSGI Server |
| **django-crispy-forms** | - | Form Rendering |
| **crispy-tailwind** | 3.4+ | Styling Framework |
| **Pillow** | - | Xử lý ảnh |
| **openpyxl** | - | Xuất Excel |
| **scikit-learn** | - | Machine Learning (Dự đoán nợ) |
| **python-dotenv** | - | Quản lý biến môi trường |
| **django-import-export** | - | Import/Export dữ liệu |
| **django-extensions** | - | Tiện ích mở rộng Django |
| **requests** | - | HTTP Client |

### Frontend
- **HTML5** / **Jinja2** Template Engine
- **TailwindCSS 3.4+** - Utility-first CSS Framework
- **JavaScript** (Vanilla + Alpine.js)
- **Bootstrap Icons** - Icon Library

### Infrastructure
- **OS**: Linux/Windows
- **Reverse Proxy**: Nginx (tùy chọn)
- **Server**: Ubuntu 20.04+ hoặc CentOS 7+

---

## 📁 Cấu Trúc Thư Mục

```
django_QLchungCu/
│
├── apartmentms/                 # Django project config
│   ├── settings.py             # Cấu hình chung
│   ├── urls.py                 # URL routing chính
│   ├── wsgi.py                 # WSGI config
│   ├── asgi.py                 # ASGI config
│   └── __init__.py
│
├── apps/                        # Các ứng dụng chính
│   ├── accounts/               # Xác thực, người dùng
│   │   ├── models.py          # User model
│   │   ├── forms.py           # Login, Register form
│   │   ├── views.py           # Auth views
│   │   ├── urls.py
│   │   └── admin.py
│   │
│   ├── buildings/              # Quản lý tòa nhà
│   │   ├── models.py          # Building, Floor, Apartment models
│   │   ├── views.py           # CRUD views
│   │   ├── forms.py
│   │   └── admin.py
│   │
│   ├── residents/              # Quản lý cư dân
│   │   ├── models.py          # Resident model
│   │   ├── views.py           # Resident management
│   │   ├── forms.py
│   │   └── admin.py
│   │
│   ├── fees/                   # Quản lý phí dịch vụ
│   │   ├── models.py          # Fee, Invoice models
│   │   ├── views.py           # Fee management
│   │   ├── forms.py
│   │   └── admin.py
│   │
│   ├── maintenance/            # Quản lý bảo trì
│   │   ├── models.py          # Maintenance request model
│   │   ├── views.py           # Maintenance management
│   │   ├── forms.py
│   │   └── admin.py
│   │
│   ├── vehicles/               # Quản lý phương tiện
│   │   ├── models.py          # Vehicle model
│   │   ├── views.py           # Vehicle management
│   │   ├── forms.py
│   │   └── admin.py
│   │
│   ├── announcements/          # Quản lý thông báo
│   │   ├── models.py          # Announcement model
│   │   ├── views.py           # Announcement management
│   │   ├── forms.py
│   │   └── admin.py
│   │
│   ├── visitors/               # Quản lý khách thăm
│   │   ├── models.py          # Visitor model
│   │   ├── views.py           # Visitor management
│   │   ├── forms.py
│   │   └── admin.py
│   │
│   ├── reports/                # Báo cáo & thống kê
│   │   ├── models.py          # Report models
│   │   ├── views.py           # Report generation
│   │   ├── overdue_risk.py    # Machine Learning models
│   │   └── admin.py
│   │
│   └── core/                   # Ứng dụng lõi
│       ├── models.py          # Common models
│       ├── context_processors.py  # Context processors
│       ├── widgets.py         # Custom widgets
│       ├── templatetags/      # Custom template tags
│       ├── management/        # Management commands
│       └── templates/         # Base templates
│
├── templates/                  # HTML templates
│   ├── base/                  # Base templates
│   ├── accounts/              # Account templates
│   ├── buildings/             # Building templates
│   ├── residents/             # Resident templates
│   ├── fees/                  # Fee templates
│   ├── maintenance/           # Maintenance templates
│   ├── vehicles/              # Vehicle templates
│   ├── announcements/         # Announcement templates
│   ├── visitors/              # Visitor templates
│   ├── reports/               # Report templates
│   └── widgets/               # Widget templates
│
├── static/                     # Static files
│   ├── css/
│   │   └── custom.css         # Custom styles
│   ├── js/                    # JavaScript files
│   └── img/                   # Images
│
├── media/                      # User uploads
│   ├── avatars/               # User avatars
│   ├── announcements/         # Announcement images
│   ├── apartments/            # Apartment images
│   ├── buildings/             # Building images
│   ├── maintenance/           # Maintenance images
│   ├── residents/             # Resident documents
│   └── vehicles/              # Vehicle images
│
├── ml_models/                  # Machine Learning models
│   ├── overdue_risk.joblib    # Risk prediction model
│   └── overdue_risk.json      # Model config
│
├── scripts/                    # Utility scripts
│   └── capture_profile_password_screenshots.py
│
├── apartmentms.sql            # Database dump
├── manage.py                  # Django management
├── requirements.txt           # Python dependencies
├── .env.example              # Environment template
├── .gitignore               # Git ignore file
└── README.md                # This file
```

---

## 🚀 Cài Đặt

### Yêu Cầu Hệ Thống

- **Python**: 3.11 hoặc cao hơn
- **MySQL**: 8.0 hoặc MariaDB 10.4+
- **pip**: Package manager Python
- **Node.js** (tùy chọn): Nếu sử dụng Tailwind CSS build

### Bước 1: Clone Repository

```bash
git clone https://github.com/yourusername/django-apartment-management.git
cd django_QLchungCu
```

### Bước 2: Tạo Virtual Environment

```bash
# Windows
python -m venv venv
venv\Scripts\activate

# macOS/Linux
python3 -m venv venv
source venv/bin/activate
```

### Bước 3: Cài Đặt Dependencies

```bash
pip install -r requirements.txt
```

### Bước 4: Cấu Hình Biến Môi Trường

Tạo file `.env` trong thư mục gốc:

```bash
# .env
DJANGO_SETTINGS_MODULE=apartmentms.settings
DEBUG=True
SECRET_KEY=your-super-secret-key-change-this-in-production
ALLOWED_HOSTS=localhost,127.0.0.1

# Database
DB_ENGINE=mysql
DB_NAME=apartmentms
DB_USER=root
DB_PASSWORD=your_password
DB_HOST=localhost
DB_PORT=3306

# Email (nếu cần gửi thông báo)
EMAIL_BACKEND=django.core.mail.backends.smtp.EmailBackend
EMAIL_HOST=smtp.gmail.com
EMAIL_PORT=587
EMAIL_USE_TLS=True
EMAIL_HOST_USER=your_email@gmail.com
EMAIL_HOST_PASSWORD=your_password

# Other
ALLOWED_FILE_EXTENSIONS=.jpg,.jpeg,.png,.pdf,.xlsx
MAX_UPLOAD_SIZE=5242880
```

### Bước 5: Cấu Hình Cơ Sở Dữ Liệu

#### Tùy chọn A: Import từ dump có sẵn
```bash
mysql -u root -p apartmentms < apartmentms.sql
```

#### Tùy chọn B: Chạy migrations (nếu bạn xóa/reset database)
```bash
python manage.py migrate
python manage.py createsuperuser  # Tạo admin
```

### Bước 6: Chạy Development Server

```bash
python manage.py runserver
```

Truy cập: `http://127.0.0.1:8000`

---

## 🔐 Đăng Nhập Lần Đầu

1. Truy cập: `http://localhost:8000/admin/`
2. Đăng nhập với superuser:
   - **Username**: admin
   - **Password**: admin123 (hoặc như bạn cấu hình)

---

## 📚 Các Lệnh Django Quan Trọng

```bash
# Tạo migrations để cập nhật schema
python manage.py makemigrations

# Áp dụng migrations
python manage.py migrate

# Tạo tài khoản super admin
python manage.py createsuperuser

# Chạy development server
python manage.py runserver

# Chạy tests
python manage.py test

# Tạo dữ liệu ảo (fixtures)
python manage.py loaddata fixtures/sample_data.json

# Mengumpulkan static files
python manage.py collectstatic --noinput

# Interactive shell
python manage.py shell

# Quản lý extensions
python manage.py shell_plus  # IPython shell
```

---

## 📊 API Endpoints

### 🔐 Authentication
| Method | Endpoint | Mô Tả |
|--------|----------|-------|
| POST | `/accounts/register/` | Đăng ký tài khoản |
| POST | `/accounts/login/` | Đăng nhập |
| GET | `/accounts/logout/` | Đăng xuất |
| POST | `/accounts/change-password/` | Thay đổi mật khẩu |

### 👥 Residents (Cư Dân)
| Method | Endpoint | Mô Tả |
|--------|----------|-------|
| GET | `/residents/` | Danh sách cư dân |
| POST | `/residents/create/` | Tạo cư dân mới |
| GET | `/residents/<id>/` | Chi tiết cư dân |
| PUT | `/residents/<id>/update/` | Cập nhật cư dân |
| DELETE | `/residents/<id>/delete/` | Xóa cư dân |

### 💳 Fees (Phí Dịch Vụ)
| Method | Endpoint | Mô Tả |
|--------|----------|-------|
| GET | `/fees/` | Danh sách phí |
| POST | `/fees/create/` | Tạo phí mới |
| GET | `/fees/<id>/` | Chi tiết phí |
| GET | `/fees/report/overdue/` | Báo cáo nợ |
| GET | `/fees/invoice/export/` | Xuất Excel hóa đơn |

### 🔧 Maintenance (Bảo Trì)
| Method | Endpoint | Mô Tả |
|--------|----------|-------|
| GET | `/maintenance/` | Danh sách công việc bảo trì |
| POST | `/maintenance/request/` | Tạo yêu cầu bảo trì |
| PUT | `/maintenance/<id>/update/` | Cập nhật trạng thái |

### 🚗 Vehicles (Phương Tiện)
| Method | Endpoint | Mô Tả |
|--------|----------|-------|
| GET | `/vehicles/` | Danh sách phương tiện |
| POST | `/vehicles/create/` | Đăng ký phương tiện |
| DELETE | `/vehicles/<id>/delete/` | Xóa phương tiện |

### 👥 Visitors (Khách Thăm)
| Method | Endpoint | Mô Tả |
|--------|----------|-------|
| GET | `/visitors/` | Danh sách khách thăm |
| POST | `/visitors/checkin/` | Check-in khách |
| POST | `/visitors/<id>/checkout/` | Check-out khách |

### 📢 Announcements (Thông Báo)
| Method | Endpoint | Mô Tả |
|--------|----------|-------|
| GET | `/announcements/` | Danh sách thông báo |
| POST | `/announcements/create/` | Tạo thông báo |
| PUT | `/announcements/<id>/update/` | Cập nhật thông báo |

### 📊 Reports (Báo Cáo)
| Method | Endpoint | Mô Tá |
|--------|----------|-------|
| GET | `/reports/revenue/` | Báo cáo doanh thu |
| GET | `/reports/maintenance/` | Báo cáo bảo trì |
| GET | `/reports/residents/` | Báo cáo cư dân |
| GET | `/reports/export/excel/` | Xuất báo cáo Excel |

---

## 🎨 Ghi Chú Về UI/UX

- **Framework CSS**: TailwindCSS 3.4+ cho design responsive, hiện đại
- **Form Handling**: django-crispy-forms + crispy-tailwind cho form layout chuyên nghiệp
- **Icons**: Bootstrap Icons hoặc FontAwesome
- **Color Scheme**: 
  - Primary: Blue (#3B82F6)
  - Success: Green (#10B981)
  - Warning: Yellow (#F59E0B)
  - Danger: Red (#EF4444)

---

## 🔒 Bảo Mật

- ✅ CSRF Protection (Django built-in)
- ✅ SQL Injection Prevention (ORM protection)
- ✅ XSS Protection (Template auto-escaping)
- ✅ Password Hashing (Django built-in bcrypt)
- ✅ Session Security (HTTPS in production)
- ✅ Permission-based Access Control

### Production Recommendations

```bash
# Bảo mật cho production
DEBUG=False
ALLOWED_HOSTS=['yourdomain.com', 'www.yourdomain.com']
SECURE_SSL_REDIRECT=True
SESSION_COOKIE_SECURE=True
CSRF_COOKIE_SECURE=True
SECURE_BROWSER_XSS_FILTER=True
SECURE_CONTENT_SECURITY_POLICY = {...}
```

---

## 🐳 Docker (Tùy Chọn)

### Cài Đặt Docker

Tạo file `Dockerfile`:

```dockerfile
FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .

CMD ["gunicorn", "apartmentms.wsgi:application", "--bind", "0.0.0.0:8000"]
```

Tạo file `docker-compose.yml`:

```yaml
version: '3.8'

services:
  db:
    image: mysql:8.0
    environment:
      MYSQL_DATABASE: apartmentms
      MYSQL_ROOT_PASSWORD: rootpassword
    volumes:
      - db_data:/var/lib/mysql

  web:
    build: .
    command: python manage.py runserver 0.0.0.0:8000
    volumes:
      - .:/app
    ports:
      - "8000:8000"
    environment:
      - DEBUG=True
      - DB_HOST=db
    depends_on:
      - db

volumes:
  db_data:
```

Chạy:
```bash
docker-compose up
```

---

## 📈 Performance Tips

1. **Database Indexing**: Các trường thường dùng trong tìm kiếm nên được index
2. **Query Optimization**: Sử dụng `select_related()` và `prefetch_related()`
3. **Caching**: Dùng Redis cache cho dữ liệu thường xuyên truy cập
4. **Pagination**: Luôn phân trang danh sách dài
5. **Static Files**: Sử dụng CDN cho hình ảnh trong production

---

## 🧪 Testing

```bash
# Chạy tất cả tests
python manage.py test

# Chạy tests cho app cụ thể
python manage.py test apps.residents

# Chạy tests với coverage
pip install coverage
coverage run --source='.' manage.py test
coverage report
```

Ví dụ test file tại `apps/reports/tests.py`

---

## 📝 Logging

```python
# settings.py
LOGGING = {
    'version': 1,
    'disable_existing_loggers': False,
    'handlers': {
        'file': {
            'level': 'INFO',
            'class': 'logging.FileHandler',
            'filename': 'logs/django.log',
        },
    },
    'loggers': {
        'django': {
            'handlers': ['file'],
            'level': 'INFO',
            'propagate': True,
        },
    },
}
```

---

## 🐛 Troubleshooting

### 1. ModuleNotFoundError: No module named 'apps'

**Giải pháp:**
```bash
# Đảm bảo apps/__init__.py tồn tại
pip install -r requirements.txt
python manage.py migrate
```

### 2. MySQL Connection Error

**Giải pháp:**
```bash
# Kiểm tra MySQL đang chạy
# Windows: net start MySQL80
# Ubuntu: sudo systemctl start mysql

# Kiểm tra .env settings
# Đảm bảo DB_HOST, DB_USER, DB_PASSWORD đúng
```

### 3. Static Files Not Loading

**Giải pháp:**
```bash
python manage.py collectstatic --noinput
# Nếu dùng development server, Django tự serve static
```

### 4. Permission Denied Errors

**Giải pháp:**
```bash
# Linux
sudo chown -R www-data:www-data /path/to/project
chmod -R 755 /path/to/project

# Windows: Chạy CMD as Administrator
```



## 📋 Roadmap

- [ ] Mobile app (React Native)
- [ ] API REST đầy đủ (Django REST Framework)
- [ ] Telegram Bot integration
- [ ] SMS notification
- [ ] QR Code check-in cho khách thăm
- [ ] Blockchain integration cho hợp đồng
- [ ] AI predictive maintenance
- [ ] Energy consumption analytics
- [ ] Real-time dashboard (WebSocket)
- [ ] Chatbot support AI

---

## 📞 Liên Hệ & Support

- **Email**: Nguyenvanqui21012005@gmail.com
- **Website**: [http://103.216.118.156:8000/](http://103.216.118.156:8000/)
- **Issues**: [GitHub Issues](https://github.com/nguyenvanqui21012005-glitch/NguyenVanQui_QLChungCu/issues)
- **Discussions**: [GitHub Discussions](https://github.com/nguyenvanqui21012005-glitch/NguyenVanQui_QLChungCu/discussions)

---



## 👏 Credit & Acknowledgments

- **Framework**: Django - The web framework for perfectionists
- **Styling**: TailwindCSS - Utility-first CSS framework
- **Icons**: Bootstrap Icons
- **Database**: MySQL/MariaDB

---

## 🔄 Version History

### v1.0.0 (2024-Present)
- ✅ Quản lý cư dân đầy đủ
- ✅ Quản lý phí dịch vụ
- ✅ Quản lý bảo trì
- ✅ Quản lý phương tiện
- ✅ Quản lý khách thăm
- ✅ Hệ thống thông báo
- ✅ Báo cáo & thống kê
- ✅ Machine Learning (dự đoán nợ)

---

