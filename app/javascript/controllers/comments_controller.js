import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["el", "arrow", "form", "textarea"]

  handleLink(e) {
    if (this.data.get('open')) {
      e.preventDefault()
      this.close()
    } else {
      this.rotateArrow()
      this.showLoader()
    }
  }

  render(e) {
    let [data, status, xhr] = e.detail
    this.el.innerHTML = xhr.response
    this.showCommentForm()
    this.data.set('open', true)
  }

  create(e) {
    let [data, status, xhr] = e.detail
    this.el.innerHTML += xhr.response
    this.textareaTarget.value = ""
  }

  close(e) {
    this.rotateArrowBack()
    this.el.innerHTML = ""
    this.hideCommentForm()
    this.data.delete('open')
  }

  rotateArrow() {
    this.arrowTarget.classList.add('rotate')
  }

  rotateArrowBack() {
   this.arrowTarget.classList.remove('rotate')
  }

  showCommentForm() {
    this.formTarget.style.display = "block"
  }

  hideCommentForm() {
    this.formTarget.style.display = "none"
  }

  showLoader() {
    this.el.innerHTML = `<div class="loader"></div>`
  }

  get el() {
    return this.elTarget
  }
}