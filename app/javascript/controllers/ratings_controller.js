import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["star", "averageRating"]

  connect() {
    this.fillStars(this.userRating)
  }

  select(e) {
    const rating = parseInt(e.target.dataset.rating)
    this.fillStars(rating)
  }

  fillStars(rating) {
    this.unfillStars()
    for (let i = 0; i < rating; i++) {
      this.starTargets[i].classList.add("star-full")
    }
  }

  unfillStars(){
    this.starTargets.forEach(el => {
      el.classList.remove("star-full")
    })
  }

  deselect(e) {
    if (!e.toElement.classList.contains('octicon-star')) {
      this.fillStars(this.userRating)
    }
  }

  render(e) {
    let [data, status, xhr] = e.detail
    this.element.innerHTML = xhr.response
  }

  get userRating() {
    return parseInt(this.data.get('userRating'))
  }
}
