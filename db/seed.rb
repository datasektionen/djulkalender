1.upto(24) do |i|
  q = Question.new
  q.publish_date = Date.new(Time.now.year, 12, i)
  q.title = "q-#{i}"
  q.question_text = "#{i}"
  q.answer = "#{i}"
  puts q.inspect
  q.save
end

