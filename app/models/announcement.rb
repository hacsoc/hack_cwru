class Announcement < ActiveRecord::Base
  validates :title, :content, presence: true, allow_blank: false

  belongs_to :author, class_name: 'User'
end
