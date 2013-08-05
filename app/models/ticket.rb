class Ticket < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  validates :title, :description, :presence => true
  validates :description, length: { minimum: 10 }

  attr_accessible :description, :title, :asset

  has_attached_file :asset #For paperclip attachments
end
