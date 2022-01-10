# frozen_string_literal: true

AuditLog.configure do
  # class name of you User model, default: 'User'
  # self.user_class = "User"
  # current_user method name in your Controller, default: 'current_user'
  # self.current_user_method = "current_user"
  # set a User.attribute to use as the name other than 'name'
  self.user_name_method = "email"
end
