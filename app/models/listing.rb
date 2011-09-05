class Listing < ActiveRecord::Base
  belongs_to :user

  def password_or_master_password?(str)
    (str == user.password) || (str == Curex::Application.config.master_password)
  end

  def contact
    user.name + "<br />" + user.phone + "<br />" + user.contact
  end
end
