# CLAUDE.md

Hướng dẫn cho Claude Code khi làm việc trong repo này.

## Dự án

`AI Practice Todo Demo` — ứng dụng Rails Todo CRUD đơn giản (xem `README.md`), dùng làm ví dụ minh hoạ cho buổi chia sẻ nội bộ về quy trình dùng AI trong công việc lập trình (design → code → test).

Stack: Ruby on Rails 7.1, SQLite, RSpec, RuboCop, Docker. Không dùng JS framework/asset pipeline — view là ERB thuần + CSS inline trong `app/views/layouts/application.html.erb`.

## Quy trình khi thực hiện 1 issue/yêu cầu

1. **Design**: nếu yêu cầu liên quan đến giao diện, thiết kế được thực hiện trước ở Claude Design. Sau khi có bản thiết kế, dùng lệnh `/design-sync` để đồng bộ 2 chiều giữa canvas Claude Design và repo này.
2. **Code**: sau khi có design (hoặc nếu yêu cầu thuần backend/logic không cần design), implement trực tiếp trong repo:
   - View nằm ở `app/views/tasks/*.html.erb`, style hiện đang là CSS thuần trong `app/views/layouts/application.html.erb` (không có Tailwind/asset pipeline).
   - Giữ nguyên convention: không dùng JS framework, không thêm Node/asset pipeline trừ khi được yêu cầu rõ.
   - Chạy `bundle exec rubocop` và `bundle exec rspec` trước khi coi là xong (xem `.github/workflows/ci.yml` để biết pipeline CI đang kiểm tra gì).
3. **Test bằng Playwright MCP**: sau khi sửa xong UI, luôn xác minh bằng trình duyệt thật qua Playwright MCP (đã cấu hình sẵn ở `.mcp.json`):
   - Khởi động server: `bin/rails server` (hoặc `docker compose up`) trước khi test.
   - Dùng Playwright MCP để mở `http://localhost:3000/tasks`, chụp screenshot, kiểm tra các phần tử UI quan trọng còn hiển thị đúng (danh sách task, nút Sửa/Xoá/Tạo mới).
   - Nếu có test Playwright trong thư mục `e2e/`, chạy `npx playwright test` để xác nhận không có gì bị hỏng.

## Lưu ý

- Không thêm decorative color bar / accent line kiểu "AI slop" vào UI — giữ phong cách tối giản nhất quán với phần slide "Consulting tối giản" đã dùng cho buổi thuyết trình.
- Đây là repo demo cho buổi chia sẻ nội bộ, ưu tiên rõ ràng dễ hiểu hơn là đầy đủ tính năng.
