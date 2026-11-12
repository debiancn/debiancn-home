(function () {
  'use strict';

  var STORAGE_KEY = 'debiancn-theme';
  var root = document.documentElement;
  var toggle = document.querySelector('.theme-toggle');

  function getSavedTheme() {
    try {
      var value = localStorage.getItem(STORAGE_KEY);
      if (value === 'light' || value === 'dark') {
        return value;
      }
    } catch (error) {
      /* localStorage 不可用时忽略 */
    }
    return null;
  }

  function getSystemTheme() {
    if (window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches) {
      return 'dark';
    }
    return 'light';
  }

  function applyTheme(theme, persist) {
    root.setAttribute('data-theme', theme);

    if (persist) {
      try {
        localStorage.setItem(STORAGE_KEY, theme);
      } catch (error) {
        /* localStorage 不可用时忽略 */
      }
    }

    if (toggle) {
      toggle.setAttribute('aria-pressed', theme === 'dark' ? 'true' : 'false');
      toggle.setAttribute('aria-label', theme === 'dark' ? '切换浅色模式' : '切换深色模式');
    }
  }

  applyTheme(getSavedTheme() || getSystemTheme(), false);

  if (toggle) {
    toggle.addEventListener('click', function () {
      var next = root.getAttribute('data-theme') === 'dark' ? 'light' : 'dark';
      applyTheme(next, true);
    });
  }

  var media = window.matchMedia ? window.matchMedia('(prefers-color-scheme: dark)') : null;

  function handleSystemChange() {
    if (!getSavedTheme()) {
      applyTheme(getSystemTheme(), false);
    }
  }

  if (media) {
    if (media.addEventListener) {
      media.addEventListener('change', handleSystemChange);
    } else if (media.addListener) {
      media.addListener(handleSystemChange);
    }
  }
})();
