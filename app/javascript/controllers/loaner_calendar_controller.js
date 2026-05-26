import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["tab", "panel", "calendar"]
  static values = { events: Array }

  connect() {
    this.calendar = null
    this.calendarRendered = false
  }

  switch(event) {
    const selectedTab = event.currentTarget.dataset.tab

    this.tabTargets.forEach((tab) => tab.classList.toggle("active", tab.dataset.tab === selectedTab))
    this.panelTargets.forEach((panel) => panel.classList.toggle("active", panel.dataset.panel === selectedTab))

    if (selectedTab === "calendar") {
      requestAnimationFrame(() => this.renderCalendar())
    }
  }

  renderCalendar() {
    if (!this.calendar) {
      this.calendar = new FullCalendar.Calendar(this.calendarTarget, {
        initialView: "dayGridMonth",
        locale: "ja",
        height: "auto",
        events: this.eventsValue,
        eventClick: (info) => {
          window.location.href = info.event.url
        },
        dateClick: (info) => {
          window.location.href = `/rentals/new?start_date=${info.dateStr}`
        }
      })
    }

    if (!this.calendarRendered) {
      this.calendar.render()
      this.calendarRendered = true
    }

    this.calendar.updateSize()
  }
}
