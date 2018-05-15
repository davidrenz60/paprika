{
  const $recipes = $('.recipe-list-item')

  const searchRecipes = (e) => {
    const query = e.target.value

    if (query === "") {
      $recipes.show()
      return
    }

    $recipes.each((idx, el) => {
      let $el = $(el)
      let name = $el.find('.recipe-name').text()


      console.log(query)
      console.log(name)

      if (match(name, query)) {
        $el.show()
      } else {
        $el.hide()
      }
    })
  }

  const match = (word, query) => {
    return (word.toLowerCase().search(query) !== -1)
  }

  $('#search-bar').on('input', searchRecipes)
}



