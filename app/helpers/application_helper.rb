module ApplicationHelper
  def title(*parts)
    unless parts.empty?
      content_for :title do
        (parts << "Ticketee").join(" - ")
       end
    end
  end

  def admins_only(&block)
    (block.call) if current_user.try(:admin?)
  end

  def authorize?(permission, thing, &block)
    block.call if can?(permission.to_sym, thing)
  end
end
