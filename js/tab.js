(function () {
  'use strict';

  var nav = document.querySelector('nav.site-nav');
  if (!nav) {
    return;
  }

  function showTab(withFallback) {
    var id = window.location.hash.slice(1);
    var target = document.getElementById(id);

    if (!target || !target.classList.contains('tab-content')) {
      if (withFallback === true) {
        target = document.getElementById('index');
      } else {
        return;
      }
    }

    var previousLink = nav.querySelector('a[aria-current="page"]');
    if (previousLink) {
      previousLink.removeAttribute('aria-current');
    }

    var previousItem = nav.querySelector('.nav-list .active');
    if (previousItem) {
      previousItem.classList.remove('active');
    }

    var link = nav.querySelector('.nav-list a[href="#' + target.id + '"]');
    if (link) {
      link.setAttribute('aria-current', 'page');
      var item = link.parentElement;
      if (item && item.tagName === 'LI') {
        item.classList.add('active');
      }
    }

    var previousSection = document.querySelector('.tab-content.tab-active');
    if (previousSection) {
      previousSection.classList.remove('tab-active');
    }
    target.classList.add('tab-active');
  }

  document.addEventListener('DOMContentLoaded', function () {
    if (document.querySelector('.tab-content')) {
      showTab(true);
      window.addEventListener('hashchange', function () {
        showTab();
      });
    }
  });
})();
