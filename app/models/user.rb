class User < ActiveRecord::Base
  include Clearance::User

  validates :name, :institution, presence: true, allow_blank: false
  has_secure_password

  # has_secure_password requires a password_digest attribute. So we'll just
  # use the sha that clearance generates already.
  alias_attribute :password_digest, :encrypted_password

  has_many :announcements, foreign_key: :author_id, dependent: :destroy
end
