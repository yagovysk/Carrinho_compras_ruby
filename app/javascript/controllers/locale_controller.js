import { Controller } from "@hotwired/stimulus"

// Conecta-se ao data-controller="locale"
export default class extends Controller {
  static targets = ["submit"]

  initialize() {
    this.submitTarget.style.display = 'none'
  }
}
