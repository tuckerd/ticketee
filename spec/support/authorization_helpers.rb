module AuthorizationHelpers
  # user is user_id
  # action is what kind of action this permission gives
  # thing can be an id or type
  def define_permission!(user, action, thing)
    Permission.create!(user: user,
                        action: action,
                        thing: thing)
  end

  def check_permission_box(permission, object)
    check "permissions_#{object.id}_#{permission}"  
  end    
end

RSpec.configure do |c|
  c.include AuthorizationHelpers
end
