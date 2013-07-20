module AuthorizationHelpers
  # user is user_id
  # action is what kind of action this permission gives
  # thing can be an id or type
  def define_permission!(user, action, thing)
    Permission.create!(user: user,
                        action: action,
                        thing: thing)
  end
end

RSpec.configure do |c|
  c.include AuthorizationHelpers
end
