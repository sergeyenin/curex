class User < ActiveRecord::Base
  has_many :listings
  after_initialize :generate_password
  validates_presence_of :contact

  private
  def generate_password

    if (password.nil?) || (password.empty?)
      self.password = (Array.new(5) {ActiveSupport::SecureRandom.random_number(10)}).join("")
    end
  end
end
