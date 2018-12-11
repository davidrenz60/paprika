import { Controller } from "stimulus"

export default class extends Controller {
  replaceLink(e) {
    let [data, status, xhr] = e.detail
    this.element.innerHTML = xhr.response
  }
}