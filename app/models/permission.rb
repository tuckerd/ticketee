class Permission < ActiveRecord::Base
  attr_accessible :user, :action, :thing 
  belongs_to :user
  belongs_to :thing, polymorphic: true
  #:user -- Who has access
  #belongs_to :actor, class_name:User, foreign_key: :user_id
  #but defaults to model name...
  #:thing - What they have access to (model)
  #:action [String] - What they are allowed to do
end
