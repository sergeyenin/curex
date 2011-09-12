class User < ActiveRecord::Base
  has_many :listings
  after_initialize :generate_password

  validates_presence_of :contact
  validates_format_of :password, :with => /^[a-zA-Z0-9\._]+$/

  #TODO: implement the same functionality without method_missing
  def method_missing(*attributes)
    if (attributes[0][/_safe$/])
      html_safe_string = send(attributes[0].to_s.gsub(/_safe$/,"").intern).html_safe
      CGI::unescapeElement( CGI::escapeHTML(html_safe_string), "BR" )
    else
      super
    end
  end

  private
  def generate_password

    if (password.nil?) || (password.empty?)
      self.password = (Array.new(5) {ActiveSupport::SecureRandom.random_number(10)}).join("")
    end
  end

end
