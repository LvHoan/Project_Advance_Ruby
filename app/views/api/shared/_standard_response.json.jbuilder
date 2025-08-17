# app/views/api/shared/_standard_response.json.jbuilder
json.status response.status
json.message @message || ""
json.total   @total   || 0