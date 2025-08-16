json.partial! 'api/shared/standard_response'
json.array @users, partial: 'api/users/user', as: :user
