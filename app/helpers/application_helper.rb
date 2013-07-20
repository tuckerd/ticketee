module ApplicationHelper
	def title(*parts)
    unless parts.empty?
      content_for :title do
        (parts << "Ticketee").join(" - ")
      end
    end
  end

  def admins_only(&block)
    yield if current_user.try(:admin?) 
  end

  def authorized?(permission, thing, &block)
    yield if can?(permission.to_sym, thing) || current_user.try(:admin?)
  end
end
