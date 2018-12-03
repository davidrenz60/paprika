import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["el", "arrow"]

  render() {
    const self = this
    this.rotateArrow()
    this.elTarget.innerHTML = self.loader()

    fetch(this.url).then(response => {
      return response.json()
    }).then(json => {
      let comments = ""

      json.forEach(comment => {
        comments += self.template(comment)
      })

      self.elTarget.innerHTML = comments
    })
  }

  rotateArrow() {
    this.arrowTarget.classList.add('rotate')
  }

  get recipeId() {
    return this.data.get('recipe-id')
  }

  get url() {
    return `/recipes/${this.recipeId}/comments`
  }

  get el() {
    return this.elTarget
  }

  template(comment) {
    return (
    `<div class="comment mb-4">
      <div class="comment-header">
        <img class="avatar" src="https://www.gravatar.com/avatar/0000.jpg">
        <div class="commenter-info mb-3 ml-5">
          <p class="m-0 font-weight-bold">Username</strong>
          <p class="m-0"><small>${comment.created_at}</small></p>
        </div>
      </div>
      <div class="comment-body">
        <p class="m-0">${comment.body}</p>
      </div>
    </div>`
    )
  }

  loader() {
    return (`<div class="loader"></div>`)
  }
}