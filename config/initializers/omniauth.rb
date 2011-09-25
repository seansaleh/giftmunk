Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '152517954842733', '16eca8b8c56f8d9071e8f568f8407dea', {:scope => "user_birthday,friends_birthday"}
end
