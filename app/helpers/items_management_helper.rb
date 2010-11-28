module ItemsManagementHelper
  def render_state(status)
    html = StringIO.new
    html << "<div id='item-status' "
    html << "class='"
    if status == Item::ALMOST_NEW
      html << "status-almost-new'"
    elsif status == Item::USED
      html << "status-used'"
    else
      html << "status-used'"
    end
    html << ">"
    html << status
    html << "</div>"

    raw(html.string)
  end
end
