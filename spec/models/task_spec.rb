require "rails_helper"

RSpec.describe Task, type: :model do
  it "is valid with a title" do
    task = Task.new(title: "Viết báo cáo tuần")
    expect(task).to be_valid
  end

  it "is invalid without a title" do
    task = Task.new(title: nil)
    expect(task).not_to be_valid
    expect(task.errors[:title]).to include("can't be blank")
  end

  it "defaults done to false" do
    task = Task.create!(title: "Task mới")
    expect(task.done).to eq(false)
  end

  describe ".pending" do
    it "returns only tasks that are not done" do
      pending_task = Task.create!(title: "Chưa xong")
      done_task = Task.create!(title: "Đã xong", done: true)

      expect(Task.pending).to include(pending_task)
      expect(Task.pending).not_to include(done_task)
    end
  end
end
