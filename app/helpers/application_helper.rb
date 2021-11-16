# frozen_string_literal: true

module ApplicationHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    direction = sort_column && sort_direction == 'asc' ? 'desc' : 'asc'
    link_to title, sort: column, direction: direction
  end

  def updatelist(list, elem)
    if list.include? elem
      list.delete_if { |i| i == elem }
    else
      list.append(elem)
    end
  end
end
