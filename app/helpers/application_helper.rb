module ApplicationHelper
  # @example Insert conditional attributes using html_attributes helper.
  #   <img <%= html_attributes(class: 'hidden') if condition? %>>
  include BetterHtml::Helpers
end
