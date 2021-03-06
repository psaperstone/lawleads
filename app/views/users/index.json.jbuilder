json.array!(@users) do |user|
  json.extract! user, :id, :company_name, :user_name, :email, :password_digest, :street_addr, :city, :zip, :biz_type
  json.url user_url(user, format: :json)
end
