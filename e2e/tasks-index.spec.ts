import { test, expect } from "@playwright/test";

// Giả định server Rails đang chạy ở http://localhost:3000
// (bin/rails server, hoặc docker compose up) trước khi chạy test này.

test("trang danh sách task hiển thị đúng", async ({ page }) => {
  await page.goto("/tasks");

  await expect(page.locator("h1")).toHaveText("Danh sách Task");
  await expect(page.getByRole("link", { name: "Tạo task mới" })).toBeVisible();
  await expect(page.locator("table")).toBeVisible();
});

test("tạo task mới thành công", async ({ page }) => {
  await page.goto("/tasks/new");

  const title = `Task test ${Date.now()}`;
  await page.getByLabel("Tiêu đề").fill(title);
  await page.getByRole("button", { name: "Lưu" }).click();

  await expect(page.locator("h1")).toHaveText(title);
});
