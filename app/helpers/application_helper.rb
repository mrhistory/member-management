module ApplicationHelper

  def sortable_hash(column)
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    params.merge(sort: column, direction: direction, page: nil)
  end

  def sortable_class(column)
    return nil unless column == sort_column
    return 'icon-chevron-up' if sortable_hash(column)[:direction] == "asc"
    return 'icon-chevron-down' if sortable_hash(column)[:direction] == "desc"
  end

  def sortable_link(column, title = nil)
    title ||= column.titleize
    link_to title, sortable_hash(column)
  end

end
