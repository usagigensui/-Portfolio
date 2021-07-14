json.array!(@schedules) do |schedule|
  json.id schedule.id
  json.title schedule.title
  json.start schedule.start_date
  json.end schedule.end_date
end