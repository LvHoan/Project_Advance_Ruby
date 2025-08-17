json.partial! 'api/shared/standard_response'

json.lessons @lessons do |lesson|
  json.id lesson.id
  json.title lesson.title
  json.content lesson.context
end