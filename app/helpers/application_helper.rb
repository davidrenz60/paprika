module ApplicationHelper
  def format_ingredients(ingredients)
    regex = /^\d+(?:\/\d+|\s\d+\/\d+|\.\d+)?|(?<=\n)\d+(?:\/\d+|\s\d+\/\d+|\.\d+)?/
    highlighted = ingredients.gsub(regex) { |match| "<strong>#{match}</strong>" }
    simple_format highlighted
  end

  def previous_path
    if request.url == request.referrer || !request.referrer
      recipes_path
    else
      request.referrer
    end
  end

  def display_datetime(dt)
    dt.strftime("%m/%d/%y at %l:%M%P")
  end
end
