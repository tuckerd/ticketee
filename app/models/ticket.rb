class Ticket < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  validates :title, :description, :presence => true
  validates :description, length: { minimum: 10 }

  attr_accessible :description, :title, :assets_attributes

  has_many :assets
  accepts_nested_attributes_for :assets
end
