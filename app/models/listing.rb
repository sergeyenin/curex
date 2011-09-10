class Listing < ActiveRecord::Base
  belongs_to :user

  #TODO: implement the same functionality without method_missing
  def method_missing(attribute)
    if (attribute[/_safe$/])
      html_safe_string = send(attribute.to_s.gsub(/_safe$/,"").intern).html_safe
      CGI::unescapeElement( CGI::escapeHTML(html_safe_string), "BR" )
    else
      super
    end
  end

  def password_or_master_password?(str)
    (str == user.password) || (str == Curex::Application.config.master_password)
  end

  def contact
    user.name + "<br />" + user.contact
  end

end
