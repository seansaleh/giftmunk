Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '226147580776537', 'a1529796296b5a17eeab49f21e343297', {:scope => "friends_birthday,user_birthday"}
end
