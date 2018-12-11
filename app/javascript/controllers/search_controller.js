import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["query", "name"]

  search() {
    this.nameTargets.forEach((el, i) => {
      let name = el.getAttribute('data-name')

      if (this.match(name, this.query)) {
        el.style.display = "block"
      } else {
        el.style.display = "none"
      }
    }, this)
  }

  match(word, query) {
    return (word.toLowerCase().search(query.toLowerCase()) !== -1)
  }

  get query() {
    return this.queryTarget.value
  }
}
