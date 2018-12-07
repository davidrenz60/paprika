import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["el", "arrow", "form", "textarea"]

  open() {
    this.rotateArrow()
    this.showLoader()
  }

  render(e) {
    let [data, status, xhr] = e.detail
    this.el.innerHTML = xhr.response
    this.showCommentForm()
  }

  create(e) {
    let [data, status, xhr] = e.detail
    this.el.innerHTML += xhr.response
    this.textareaTarget.value = ""
  }

  rotateArrow() {
    this.arrowTarget.classList.add('rotate')
  }

  showCommentForm() {
    this.formTarget.style.display = "block"
  }

  showLoader() {
    this.el.innerHTML = `<div class="loader"></div>`
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


}