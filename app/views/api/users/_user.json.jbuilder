json.extract! user, :id, :name, :email, :created_at, :updated_at
json.avatar_url url_for(user.avatar) if user.avatar.attached?