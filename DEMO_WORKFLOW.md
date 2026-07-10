# Quy trình demo: Design → Code → Test

Tài liệu này mô tả quy trình dùng **Claude Design** (thiết kế) + **Claude Code CLI** (viết code, có Playwright MCP để tự kiểm thử bằng trình duyệt thật) cho 1 issue/yêu cầu, dùng để demo trực tiếp trong buổi chia sẻ.

## Chuẩn bị trước buổi demo (làm 1 lần)

1. Cài/cập nhật Claude Code CLI lên bản mới nhất (cần bản hỗ trợ `/design-sync`):
   ```bash
   npm install -g @anthropic-ai/claude-code
   claude --version
   ```
2. Clone repo này về máy (nếu chưa có) và mở terminal tại thư mục repo:
   ```bash
   git clone https://github.com/khoaut2802/demo-ai-shareing.git
   cd demo-ai-shareing
   ```
3. Cài dependency cho Playwright (chỉ cần làm 1 lần):
   ```bash
   npm install
   npx playwright install chromium
   ```
4. Mở Claude Code CLI ngay tại thư mục repo:
   ```bash
   claude
   ```
   Claude Code sẽ tự đọc `CLAUDE.md` và `.mcp.json` (đã cấu hình sẵn Playwright MCP) — không cần setup thêm gì trong phiên demo.
5. Đăng nhập/mở Claude Design (claude.ai) ở màn hình còn lại.

## Luồng demo trực tiếp (3 bước, đúng như bạn sẽ ra lệnh)

### Bước 1 — Design (ở Claude Design)

Ví dụ lệnh:
> "Thiết kế lại giao diện trang danh sách Task (Tasks index) cho gọn gàng, chuyên nghiệp hơn — vẫn giữ bảng liệt kê task với cột Tiêu đề / Trạng thái / Hành động, nhưng thêm khoảng trắng, phân biệt rõ task đã xong bằng màu nhạt hơn."

### Bước 2 — Đồng bộ + Code (ở Claude Code CLI, trong thư mục repo)

```
/design-sync
```

rồi ra lệnh, ví dụ:
> "Áp dụng design vừa /design-sync vào app/views/tasks/index.html.erb và style trong layouts/application.html.erb. Giữ đúng convention hiện tại (không thêm JS framework, không thêm asset pipeline)."

### Bước 3 — Test bằng Playwright MCP (Claude Code tự làm, hoặc ra lệnh rõ)

Nếu Claude Code không tự chạy, ra lệnh trực tiếp:
> "Khởi động `bin/rails server`, dùng Playwright MCP mở http://localhost:3000/tasks, chụp screenshot và xác nhận bảng task + 2 nút Sửa/Xoá vẫn hiển thị đúng sau khi đổi giao diện."

Hoặc chạy bộ test đã viết sẵn:
```bash
bin/rails server &
npx playwright test
```

## Ghi chú khi demo

- Nếu `/design-sync` báo cần Claude Code bản mới hơn, chạy `npm update -g @anthropic-ai/claude-code` trước buổi demo, đừng để lúc demo mới cập nhật (mất thời gian chờ mạng).
- File `e2e/tasks-index.spec.ts` là bộ test Playwright có sẵn — có thể chạy trước để chắc chắn baseline đang xanh, rồi mới demo thay đổi UI để so sánh trước/sau.
- Toàn bộ context project (stack, convention, quy trình) đã nằm trong `CLAUDE.md` — Claude Code tự đọc file này, không cần giải thích lại từ đầu mỗi lần mở phiên mới.
