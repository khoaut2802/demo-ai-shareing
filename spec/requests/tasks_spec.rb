require "rails_helper"

RSpec.describe "Tasks", type: :request do
  let(:valid_attributes) { { title: "Chuẩn bị slide demo", description: "Cho buổi AI Sharing" } }
  let(:invalid_attributes) { { title: "" } }

  describe "GET /tasks" do
    it "returns success" do
      get tasks_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /tasks/:id" do
    it "returns success" do
      task = Task.create!(valid_attributes)
      get task_path(task)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /tasks" do
    context "with valid params" do
      it "creates a new Task" do
        expect {
          post tasks_path, params: { task: valid_attributes }
        }.to change(Task, :count).by(1)
      end

      it "redirects to the created task" do
        post tasks_path, params: { task: valid_attributes }
        expect(response).to redirect_to(Task.last)
      end
    end

    context "with invalid params" do
      it "does not create a new Task" do
        expect {
          post tasks_path, params: { task: invalid_attributes }
        }.not_to change(Task, :count)
      end

      it "renders unprocessable_entity" do
        post tasks_path, params: { task: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /tasks/:id" do
    it "updates the task" do
      task = Task.create!(valid_attributes)
      patch task_path(task), params: { task: { done: true } }
      task.reload
      expect(task.done).to eq(true)
    end
  end

  describe "DELETE /tasks/:id" do
    it "destroys the task" do
      task = Task.create!(valid_attributes)
      expect {
        delete task_path(task)
      }.to change(Task, :count).by(-1)
    end
  end
end
