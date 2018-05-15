{
  const $recipes = $('.recipe-list-item')

  searchRecipes = (e) => {
    const query = e.target.value

    if (query === "") {
      $recipes.show()
      return
    }

    $recipes.each((idx, el) => {
      let $el = $(el)
      if (match($el.text().trim(), query)) {
        $el.show()
      } else {
        $el.hide()
      }
    })
  }

  match = (word, query) => {
    return (word.toLowerCase().search(query) !== -1)
  }

  $('#search-bar').on('keyup', searchRecipes)
}



