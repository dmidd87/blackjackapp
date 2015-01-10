class Registration < ActiveRecord::Base

  before_save { |user| user.email_address = email_address.downcase }

  def full_name
    "#{first_name} #{last_name}"
  end

  has_secure_password
end
