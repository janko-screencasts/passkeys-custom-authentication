import { Controller } from "@hotwired/stimulus"
import * as WebAuthnJSON from "@github/webauthn-json"

export default class extends Controller {
  static values = { data: Object }
  static targets = ["result"]

  async setup() {
    const result = await WebAuthnJSON.create({ publicKey: this.dataValue })

    this.resultTarget.value = JSON.stringify(result)
    this.element.requestSubmit()
  }

  async auth() {
    const result = await WebAuthnJSON.get({ publicKey: this.dataValue })

    this.resultTarget.value = JSON.stringify(result)
    this.element.requestSubmit()
  }
}
