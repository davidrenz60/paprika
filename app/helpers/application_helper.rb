module ApplicationHelper
  def format_ingredients(ingredients)
    regex = /^\d+(?:\/\d+|\s\d+\/\d+|\.\d+)?|(?<=\n)\d+(?:\/\d+|\s\d+\/\d+|\.\d+)?/
    highlighted = ingredients.gsub(regex) { |match| "<strong>#{match}</strong>" }
    simple_format highlighted
  end

  def previous_path
    request.referrer || recipes_path
  end
end
