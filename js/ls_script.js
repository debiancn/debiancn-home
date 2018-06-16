/* 设置小屏幕设备 点击切换菜单栏 */
$('.navMobiRight').bind('click', function () {
  $('.menuList').toggle();
});

/* 设置导航菜单 固定在页面最上方 */
function topFixed () {
  if (window.innerWidth >= 700 && window.scrollY >= 63) {
    $('.menuListDiv').css({
      'position': 'fixed',
      'top': '0',
      'left': '0'
    });
  } else if (window.innerWidth >= 700) {
    $('.menuListDiv').css({
      'position': 'relative',
      'top': '0',
      'left': '0'
    });
    $('.menuList').show();
  } else if (window.innerWidth <= 700) {
    $('.menuListDiv').css({
      'position': 'relative',
      'top': '0',
      'left': '0'
    });
  }
}

$(window).bind('load', function () {
  topFixed();
}).bind('scroll', function () {
  topFixed();
}).bind('resize', function () {
  topFixed();
});


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


window.addEventListener('hashchange', showTab)



document.addEventListener('DOMContentLoaded', function (event) {
  showTab(true)



  /*修改新闻时间格式*/
  var _month = [
    ['Jan', '01'],
    ['Feb', '02'],
    ['Mar', '03'],
    ['Apr', '04'],
    ['May', '05'],
    ['Jun', '06'],
    ['Jul', '07'],
    ['Aug', '08'],
    ['Sep', '09'],
    ['Oct', '10'],
    ['Nov', '11'],
    ['Dec', '12'],
  ];
  $('.newsContainer .newsDate').each(function () {
    if ($(this).html().match(/,/)) {
      $(this).html(
        (function (innerHTML) {
//		    console.log( innerHTML );
          var _r = innerHTML.split(',')[1].split(" ");
          for (let i in _month) {
            if (_month[i][0] === _r[2]) {
              _r[2] = _month[i][1];
              break;
            }
          }
          // 也可以返回和 安全更新 一样的格式， 这里的格式和之前的格式是一样的
          // return _r[3] + '年' + _r[2] + '月' + _r[1] + '日';
          return '[' + _r[3] + '/' + _r[2] + '/' + _r[1] + ']';
        }($(this).html()))
      );
    } else {
      // 修改 ’2017年4月25‘ 格式 转换为 [2017/4/25]
      $(this).html(
        (function (innerHTML) {
          var _r = innerHTML.split('年');
          _r[1] = _r[1].split('月');
          _r[2] = _r[1][1].split('日')[0];
          _r[1] = _r[1][0];
          _r[1] = parseInt(_r[1]) < 10 ? '0' + _r[1] : _r[1];
          return '[' + _r[0] + '/' + _r[1] + '/' + _r[2] + ']';
        }($(this).html()))
      );
    }
  });

})