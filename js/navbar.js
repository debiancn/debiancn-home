(function () {
  'use strict';

  var header = document.querySelector('.site-header');
  var menuToggle = document.querySelector('.menu-toggle');
  var nav = document.getElementById('site-nav');

  if (!header || !menuToggle || !nav) {
    return;
  }

  function openNav() {
    header.classList.add('is-nav-open');
    menuToggle.setAttribute('aria-expanded', 'true');
    menuToggle.setAttribute('aria-label', '关闭菜单');
  }

  function closeNav() {
    header.classList.remove('is-nav-open');
    menuToggle.setAttribute('aria-expanded', 'false');
    menuToggle.setAttribute('aria-label', '打开菜单');
  }

  menuToggle.addEventListener('click', function () {
    if (header.classList.contains('is-nav-open')) {
      closeNav();
    } else {
      openNav();
    }
  });

  nav.addEventListener('click', function (event) {
    var link = event.target.closest ? event.target.closest('a') : null;
    if (link && window.matchMedia('(max-width: 768px)').matches) {
      closeNav();
    }
  });

  document.addEventListener('keydown', function (event) {
    if (event.key === 'Escape' && header.classList.contains('is-nav-open')) {
      closeNav();
      menuToggle.focus();
    }
  });

  document.addEventListener('click', function (event) {
    if (header.classList.contains('is-nav-open') && !header.contains(event.target)) {
      closeNav();
    }
  });

  var desktop = window.matchMedia('(min-width: 769px)');

  function handleBreakpoint(event) {
    if (event.matches) {
      closeNav();
    }
  }

  if (desktop.addEventListener) {
    desktop.addEventListener('change', handleBreakpoint);
  } else if (desktop.addListener) {
    desktop.addListener(handleBreakpoint);
  }
})();
