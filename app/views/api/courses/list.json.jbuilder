json.partial! 'api/shared/standard_response'

json.courses @courses do |course|
  json.id course.id
  json.title course.title
  json.description course.description
  json.image_url course.image_url
end
