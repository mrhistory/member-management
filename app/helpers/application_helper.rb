module ApplicationHelper

  def sortable_hash(column)
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    params.merge(sort: column, direction: direction, page: nil)
  end

  def sortable_class(column)
    return nil unless column == sort_column
    return 'glyphicon glyphicon-chevron-up' if sortable_hash(column)[:direction] == "asc"
    return 'glyphicon glyphicon-chevron-down' if sortable_hash(column)[:direction] == "desc"
  end

  def sortable_link(column, title = nil)
    title ||= column.titleize
    link_to title, sortable_hash(column)
  end

  def display_field(field, field_name)
    "<strong>#{field_name}</strong>
    <br/>
    #{field}".html_safe
  end

  def display_email(field, field_name)
    "<strong>#{field_name}</strong>
    <br/>
    <a href='mailto:#{field}'>#{field}</a>".html_safe
  end

  def display_phone(field, field_name)
    "<strong>#{field_name}</strong>
    <br/>
    <a href='tel:#{field}'>#{field}</a>".html_safe
  end

end
