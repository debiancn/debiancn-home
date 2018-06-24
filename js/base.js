/* 设置小屏幕设备 点击切换菜单栏 */
document.getElementsByClassName('header-button')[0].addEventListener('click', function () {
  document.getElementsByClassName('navbar-collapse')[0].classList.toggle('navbar-collapse-slidedown')
})


/* 设置导航菜单 固定在页面最上方 */
function topFixed () {
  let navbar = document.getElementsByClassName('navbar')[0]
  let logo_box = document.getElementsByTagName('header')[0]
  if (window.innerWidth > 544) {
    if (window.scrollY > parseFloat(window.getComputedStyle(logo_box).height)) {
      let navbar_style = window.getComputedStyle(navbar)
      logo_box.style.paddingBottom =
        parseFloat(navbar_style.height) +
        parseFloat(navbar_style.borderBottomWidth) +
        'px'
      navbar.classList.add('navbar-top')
    } else {
      navbar.classList.remove('navbar-top')
      logo_box.style.paddingBottom = 0
    }
  } else {
    navbar.classList.remove('navbar-top')
    logo_box.style.paddingBottom = 0
  }
}

document.addEventListener('DOMContentLoaded', topFixed)
window.addEventListener('scroll', topFixed)
window.addEventListener('resize', topFixed)


/* tab */
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
  window.scrollTo(0, 0)
}


document.addEventListener('DOMContentLoaded', function (event) {
  if (document.getElementsByTagName('section').length) {
    showTab(true)
    window.addEventListener('hashchange', showTab)
  }
})
