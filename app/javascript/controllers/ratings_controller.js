import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["star", "ratingFormDiv"]

  connect() {
    this.fillStars(this.userRating)
  }

  select(e) {
    const rating = parseInt(e.target.dataset.rating)
    this.fillStars(rating)
  }

  fillStars(rating) {
    this.starClasses.forEach(starClass => {
      this.ratingFormDivTarget.classList.remove(starClass)
    }, this)

    this.ratingFormDivTarget.classList.add('rating-form-stars-' + rating)
  }

  reset(e) {
    this.fillStars(this.userRating)
  }

  render(e) {
    let [data, status, xhr] = e.detail
    let html = data.html
    let userRating = data.user_rating
    let averageRating = data.average_rating
    this.data.set('userRating', userRating)

    this.element.innerHTML = html
    this.updateAverageRating(averageRating)
  }

  updateAverageRating(rating) {
    this.averageRatingDiv.classList.remove('rating-stars-' + this.averageRating.split('.').join(''))
    this.averageRatingDiv.classList.add('rating-stars-' + rating.split('.').join(''))
    this.data.set('averageRating', rating)
  }

  get userRating() {
    return this.data.get('userRating')
  }

  get averageRatingDiv() {
    return document.getElementById('average-rating')
  }

  get averageRating() {
    return this.data.get('averageRating')
  }

  get starClasses() {
    return ['rating-form-stars-1', 'rating-form-stars-2', 'rating-form-stars-3', 'rating-form-stars-4', 'rating-form-stars-5']
  }
}
