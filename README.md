# AI Practice Todo Demo

Ứng dụng Rails Todo CRUD đơn giản, dùng làm ví dụ minh hoạ cho buổi chia sẻ nội bộ **"AI in Practice: Build Smarter, Ship Faster"**. Mục tiêu của repo này không phải là bản thân app, mà là **quy trình chuẩn chỉnh (CI)** đi kèm — cách một dự án Rails được kiểm tra tự động (lint + test) mỗi khi có code mới, giống với cách team nên vận hành khi dùng AI để viết code nhanh hơn.

## Tính năng app

- Quản lý danh sách Task: tạo, xem, sửa, đánh dấu hoàn thành, xoá (CRUD đầy đủ).
- Không phụ thuộc JavaScript/asset pipeline — chỉ Ruby, ERB, SQLite. Chạy được ở bất kỳ máy nào có Ruby, không cần cài Node.
- Có bộ test (RSpec) và lint (RuboCop) đi kèm.

## Cấu trúc quy trình CI (GitHub Actions)

File `.github/workflows/ci.yml` định nghĩa pipeline chạy tự động trên GitHub mỗi khi **push** hoặc mở **pull request** vào nhánh `main`:

1. **Checkout code** — lấy code mới nhất từ repo.
2. **Set up Ruby** — cài đúng phiên bản Ruby, cache gem để lần chạy sau nhanh hơn.
3. **Chuẩn bị database test** — `bin/rails db:prepare` tạo schema cho SQLite.
4. **RuboCop (lint)** — kiểm tra style code tự động, chặn code không đúng convention.
5. **RSpec (test)** — chạy toàn bộ test (model + request spec), đảm bảo tính năng CRUD hoạt động đúng trước khi merge.

Nếu bất kỳ bước nào fail, GitHub sẽ đánh dấu đỏ ngay trên commit/PR — đây là điểm demo chính: **AI có thể viết code rất nhanh, nhưng pipeline này là lưới an toàn đảm bảo code AI viết ra vẫn đúng chuẩn và không phá vỡ tính năng cũ.**

## Chạy bằng Docker (khuyến nghị — môi trường giống nhau cho mọi máy)

Không cần cài Ruby/SQLite trên máy, chỉ cần Docker:

```bash
git clone https://github.com/khoaut2802/demo-ai-shareing.git
cd demo-ai-shareing
docker compose up --build
```

Mở `http://localhost:3000`. Container tự động chạy `db:prepare` (tạo schema) trước khi start server, nên chỉ cần đúng 1 lệnh là chạy được ngay — bất kể máy đang dùng hệ điều hành gì hay đã cài Ruby phiên bản nào.

Dữ liệu SQLite được lưu ở Docker volume `sqlite_data`, không mất khi tắt/bật lại container. Dừng app: `docker compose down` (thêm `-v` nếu muốn xoá luôn dữ liệu).

Chỉ dùng Docker (không cần docker compose):

```bash
docker build -t ai-practice-todo-demo .
docker run -p 3000:3000 ai-practice-todo-demo
```

Pipeline CI cũng tự build image này và kiểm tra container khởi động + trả response thành công (job `docker` trong `.github/workflows/ci.yml`) — nếu ai đó sửa Dockerfile làm hỏng image, pipeline sẽ báo đỏ ngay, giống như khi RSpec/RuboCop fail.

## Chạy thử ở local

```bash
bundle install
bin/rails db:prepare
bin/rails server
```

Mở `http://localhost:3000`.

## Chạy test & lint thủ công

```bash
bundle exec rspec       # chạy test
bundle exec rubocop     # kiểm tra style
```

## Gợi ý kịch bản demo

1. Mở tab **Actions** trên GitHub, chỉ pipeline vừa chạy xanh (pass) sau lần push đầu tiên.
2. Sửa một dòng code cố ý sai style hoặc phá 1 test, push lên nhánh mới, mở Pull Request → cho mọi người thấy pipeline tự động **chạy đỏ (fail)** và chặn merge.
3. Sửa lại, push tiếp → pipeline xanh trở lại → merge.
4. Nhấn mạnh: đây chính là quy trình nên áp dụng khi để AI hỗ trợ viết code — luôn có bước kiểm tra tự động độc lập với AI.
