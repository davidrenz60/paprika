import { Controller } from "stimulus"

export default class extends Controller {
  static targets = []

  favorite(e) {
    e.preventDefault()
    const self = this

    fetch(this.favoriteUrl).then(response => {
      return response.status
    }).then(status => {
      if (status === 200) {
        self.replaceFavoriteLink()
      }
    })
  }

  unfavorite(e) {
    e.preventDefault()
    const self = this

    fetch(this.unfavoriteUrl).then(response => {
      return response.status
    }).then(status => {
      if (status === 200) {
        self.replaceUnfavoriteLink()
      }
    })
  }

  replaceFavoriteLink() {
    const html = `<a href="" id="unfavorite-link" data-action="click->favorite#unfavorite"></a>`

    this.element.innerHTML = html
  }

  replaceUnfavoriteLink() {
    const html = `<a href="" id="favorite-link" data-action="click->favorite#favorite"></a>`

    this.element.innerHTML = html
  }

  get favoriteUrl() {
    return `/recipes/${this.recipeId}/favorite`
  }

  get unfavoriteUrl() {
    return `/recipes/${this.recipeId}/unfavorite`
  }

  get recipeId() {
    return this.data.get('recipe-id')
  }
}