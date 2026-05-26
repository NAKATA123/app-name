import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "status"]
  static values = {
    createUrl: String,
    updateUrl: String,
    noticeDate: String,
    noticeId: Number
  }

  connect() {
    this.saveTimer = null
  }

  queueSave() {
    this.setStatus("編集中")
    clearTimeout(this.saveTimer)
    this.saveTimer = setTimeout(() => this.save(), 700)
  }

  saveNow() {
    clearTimeout(this.saveTimer)
    this.save()
  }

  async save() {
    const content = this.inputTarget.value
    const response = await fetch(this.url, {
      method: this.method,
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content
      },
      body: JSON.stringify({
        notice_date: this.noticeDateValue,
        notice: { content: content }
      })
    })

    if (!response.ok) {
      this.setStatus("保存できませんでした")
      return
    }

    const data = await response.json()

    if (data.id) {
      this.noticeIdValue = data.id
      this.updateUrlValue = `/notices/${data.id}`
    } else if (content.trim() === "") {
      this.noticeIdValue = 0
      this.updateUrlValue = ""
    }

    this.setStatus(content.trim() === "" ? "クリア済み" : "保存済み")
  }

  get method() {
    return this.hasNoticeIdValue && this.noticeIdValue > 0 ? "PATCH" : "POST"
  }

  get url() {
    return this.method === "PATCH" ? this.updateUrlValue : this.createUrlValue
  }

  setStatus(text) {
    this.statusTarget.textContent = text
  }
}
