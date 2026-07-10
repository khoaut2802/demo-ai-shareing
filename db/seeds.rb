Task.find_or_create_by!(title: "Chuẩn bị slide AI Sharing") do |task|
  task.description = "Tổng hợp nội dung từ video training thành bộ slide."
  task.done = true
end

Task.find_or_create_by!(title: "Viết kịch bản thuyết trình") do |task|
  task.description = "Kịch bản DOCX đi kèm slide."
  task.done = true
end

Task.find_or_create_by!(title: "Demo Rails app + CI pipeline") do |task|
  task.description = "Cho buổi chia sẻ AI in Practice."
  task.done = false
end
