class User < ActiveRecord::Base
  has_many :listings
  after_initialize :generate_password

  validates_presence_of :contact
  validates_format_of :password, :with => /^[a-zA-Z0-9\._]+$/

  private
  def generate_password

    if (password.nil?) || (password.empty?)
      self.password = (Array.new(5) {ActiveSupport::SecureRandom.random_number(10)}).join("")
    end
  end
end
