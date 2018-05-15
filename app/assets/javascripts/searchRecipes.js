{
  const recipes = document.querySelectorAll('.recipe-list-item')

  const searchRecipes = (e) => {
    const query = e.target.value

    if (query === "") {
      recipes.forEach(el => el.style.display = "")
      return
    }

    recipes.forEach(el => {
      let name = el.querySelector('.recipe-name').innerText

      if (match(name, query)) {
        el.style.display = ""
      } else {
        el.style.display = "none"
      }
    })
  }

  const match = (word, query) => {
    return (word.toLowerCase().search(query) !== -1)
  }

  document.getElementById('search-bar').addEventListener('input', searchRecipes)
}



