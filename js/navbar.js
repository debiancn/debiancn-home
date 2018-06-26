const SMALL_SCREEN_WIDTH = 544


/* header */
document.getElementsByClassName('header-button')[0].addEventListener('click', function () {
  document.getElementsByClassName('navbar-collapse')[0].classList.toggle('navbar-collapse-slidedown')
})


/* navbar */
function fixTop () {
  let navbar = document.getElementsByClassName('navbar')[0]
  let header = document.getElementsByTagName('header')[0]
  if (window.innerWidth > SMALL_SCREEN_WIDTH) {
    let header_height = parseFloat(window.getComputedStyle(header).height)
    if (window.scrollY > header_height) {
      let navbar_style = window.getComputedStyle(navbar)
      header.style.paddingBottom =
        parseFloat(navbar_style.height) +
        parseFloat(navbar_style.borderBottomWidth) +
        'px'
      navbar.classList.add('navbar-top')
      return
    }
  }
  navbar.classList.remove('navbar-top')
  header.style.paddingBottom = 0
}

document.addEventListener('DOMContentLoaded', fixTop)
window.addEventListener('scroll', fixTop)
window.addEventListener('resize', fixTop)
