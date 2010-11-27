module ApplicationHelper
  # Prints all the errors for an active record object
  def errors_for(object)
    error_msgs = object.errors.values.flatten
    if error_msgs.empty?
      ""
    else
      html = StringIO.new
      html << "<div class='errors-form-for'><div class='errors-form-for-msg'>Hemos encontrado algunos errores:</div><ul>"
      error_msgs.each do |error_msg|
        html << "<li>#{error_msg}</li>"
      end
      html << "</div>"
      raw(html.string)
    end
  end
end
