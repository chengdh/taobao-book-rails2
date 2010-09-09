# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def active_tab(active_tab_index)
    active_tab = params[:active_tab]
    active_tab = "search_douban" if active_tab.blank?
    (active_tab == active_tab_index) ? "active" : ""
  end
end
