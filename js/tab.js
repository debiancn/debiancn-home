function showTab (withFallback) {
  let section_target_tab = document.getElementById(
    window.location.hash.substr(1))
  if (!section_target_tab) {
    if (withFallback === true) {
      section_target_tab = document.getElementById('index')
    } else {
      return
    }
  }

  let nav = document.getElementsByTagName('nav')[0]
  let li_active = nav.getElementsByClassName('active')[0]
  if (li_active) {
    li_active.classList.remove('active')
  }
  let a_tab = nav.querySelector(
    '.navbar-tabs > li > a[href="#' + section_target_tab.id + '"]')
  if (a_tab) {
    a_tab.parentElement.classList.add('active')
  }

  let section_prev_tab = document.getElementsByClassName('tab-active')[0]
  if (section_prev_tab) {
    section_prev_tab.classList.remove('tab-active')
  }
  section_target_tab.classList.add('tab-active')

  if (window.innerWidth > SMALL_SCREEN_WIDTH) {
    let header = document.getElementsByTagName('header')[0]
    let header_height = parseFloat(window.getComputedStyle(header).height)
    if (window.scrollY > header_height) {
      window.scrollTo(0, header_height + 1)
    }
  }
}

document.addEventListener('DOMContentLoaded', function (event) {
  if (document.getElementsByTagName('section').length) {
    showTab(true)
    window.addEventListener('hashchange', showTab)
  }
})
