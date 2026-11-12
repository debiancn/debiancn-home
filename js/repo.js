/* ==========================================================================
   Debian 中文软件仓库 — repo.js
   1. 全仓库软件包搜索（数据来自 /info/*.json）
   2. 将 nginx autoindex 的 <pre> 列表转换为现代文件表格
   ========================================================================== */
(function () {
  'use strict';

  /* ------------------------------------------------------------------------
     全仓库软件包搜索
     ------------------------------------------------------------------------ */

  var INDEX_URLS = [
    '/info/trixie.json',
    '/info/bookworm.json',
    '/info/bullseye.json'
  ];
  var CACHE_KEY = 'debiancn-repo-search-v1';
  var CACHE_TTL = 12 * 60 * 60 * 1000; // 12 小时
  var MAX_RESULTS = 20;

  var form = document.querySelector('.search-form');
  var input = document.getElementById('search');
  var list = document.getElementById('search-results');

  if (form && input && list) initSearch(form, input, list);

  function initSearch(formEl, inputEl, listEl) {
    var items = null;
    var loading = false;
    var failed = false;
    var results = [];
    var active = -1;

    inputEl.addEventListener('input', onInput);
    inputEl.addEventListener('focus', function () {
      if (inputEl.value.trim()) onInput();
    });
    inputEl.addEventListener('keydown', onKeyDown);

    formEl.addEventListener('submit', function (event) {
      event.preventDefault();
      if (active >= 0) {
        choose(active);
      } else if (results.length) {
        choose(0);
      }
    });

    document.addEventListener('click', function (event) {
      if (!formEl.contains(event.target)) close();
    });

    document.addEventListener('keydown', function (event) {
      var target = event.target;
      var editing = target && (target.tagName === 'INPUT' ||
        target.tagName === 'TEXTAREA' || target.tagName === 'SELECT' ||
        target.isContentEditable);

      if (event.key === '/' && !editing) {
        event.preventDefault();
        inputEl.focus();
      } else if ((event.ctrlKey || event.metaKey) && (event.key === 'k' || event.key === 'K')) {
        event.preventDefault();
        inputEl.focus();
        inputEl.select();
      } else if (event.key === 'Escape' && formEl.contains(target)) {
        close();
      }
    });

    function onInput() {
      var query = inputEl.value.trim();
      if (!query) {
        close();
        return;
      }

      ensureIndex();

      if (loading) {
        results = [];
        active = -1;
        renderStatus('正在载入软件包索引…');
        return;
      }
      if (failed) {
        results = [];
        active = -1;
        renderStatus('全仓库搜索暂不可用，请稍后重试');
        return;
      }
      if (!items) return;

      results = match(items, query);
      active = results.length ? 0 : -1;
      render();
    }

    function onKeyDown(event) {
      if (event.key === 'ArrowDown') {
        if (!results.length) return;
        event.preventDefault();
        active = (active + 1) % results.length;
        render();
      } else if (event.key === 'ArrowUp') {
        if (!results.length) return;
        event.preventDefault();
        active = (active - 1 + results.length) % results.length;
        render();
      } else if (event.key === 'Enter') {
        if (active >= 0) {
          event.preventDefault();
          choose(active);
        }
      } else if (event.key === 'Escape') {
        close();
      } else if (event.key === 'Tab') {
        close();
      }
    }

    function ensureIndex() {
      if (items || loading || failed) return;

      if (typeof window.fetch !== 'function' || typeof window.Promise !== 'function') {
        failed = true;
        return;
      }

      var cached = readCache();
      if (cached) {
        items = cached;
        return;
      }

      loading = true;
      Promise.all(INDEX_URLS.map(fetchJSON))
        .then(function (documents) {
          items = buildIndex(documents);
          writeCache(items);
          return items;
        })
        .catch(function () {
          failed = true;
        })
        .then(function () {
          loading = false;
          // 索引加载完成时输入框里可能已经有内容，补一次渲染
          if (inputEl.value.trim()) onInput();
        });
    }

    function render() {
      listEl.textContent = '';
      if (!results.length) {
        renderStatus('未找到匹配的软件包');
        return;
      }

      for (var i = 0; i < results.length; i++) {
        var option = document.createElement('li');
        option.className = 'search-result';
        option.id = 'search-option-' + i;
        option.setAttribute('role', 'option');
        option.setAttribute('aria-selected', i === active ? 'true' : 'false');
        option.textContent = results[i].name;

        (function (index) {
          option.addEventListener('mousedown', function (event) {
            event.preventDefault();
            choose(index);
          });
        })(i);

        listEl.appendChild(option);
      }

      open();
      if (active >= 0) {
        inputEl.setAttribute('aria-activedescendant', 'search-option-' + active);
      } else {
        inputEl.removeAttribute('aria-activedescendant');
      }
    }

    function renderStatus(message) {
      listEl.textContent = '';
      var status = document.createElement('li');
      status.className = 'search-status';
      status.setAttribute('role', 'presentation');
      status.textContent = message;
      listEl.appendChild(status);
      open();
      inputEl.removeAttribute('aria-activedescendant');
    }

    function open() {
      listEl.removeAttribute('hidden');
      inputEl.setAttribute('aria-expanded', 'true');
    }

    function close() {
      listEl.setAttribute('hidden', 'hidden');
      listEl.textContent = '';
      inputEl.setAttribute('aria-expanded', 'false');
      inputEl.removeAttribute('aria-activedescendant');
      active = -1;
    }

    function choose(index) {
      var item = results[index];
      if (!item) return;
      window.location.href = item.dir;
    }
  }

  function fetchJSON(url) {
    return fetch(url, { credentials: 'same-origin' }).then(function (response) {
      if (!response.ok) throw new Error('HTTP ' + response.status);
      return response.json();
    });
  }

  /*
   * /info/<codename>.json 的结构：
   *   { "main": { "amd64": [ { "Package": "...", "Filename": "pool/main/..." } ] } }
   * 这里只保留包名与包所在目录，并按包名去重。
   */
  function buildIndex(documents) {
    var dirs = Object.create(null);

    for (var d = 0; d < documents.length; d++) {
      var components = documents[d];
      if (!components || typeof components !== 'object') continue;

      for (var component in components) {
        if (!Object.prototype.hasOwnProperty.call(components, component)) continue;
        var arches = components[component];
        if (!arches || typeof arches !== 'object') continue;

        for (var arch in arches) {
          if (!Object.prototype.hasOwnProperty.call(arches, arch)) continue;
          var packages = arches[arch];
          if (!packages || !packages.length) continue;

          for (var i = 0; i < packages.length; i++) {
            var pkg = packages[i];
            if (!pkg) continue;

            var name = pkg.Package;
            var filename = pkg.Filename;
            if (!name || !filename) continue;
            // 调试包通常只是附带的二进制包，搜索时隐藏
            if (/-dbgsym$|-dbg$/.test(name)) continue;

            if (!dirs[name]) dirs[name] = toDirectory(filename);
          }
        }
      }
    }

    var names = Object.keys(dirs).sort();
    var items = [];
    for (var n = 0; n < names.length; n++) {
      items.push({ name: names[n], dir: dirs[names[n]] });
    }
    return items;
  }

  function toDirectory(filename) {
    var slash = filename.lastIndexOf('/');
    var directory = slash < 0 ? '' : filename.slice(0, slash + 1);
    return '/' + directory;
  }

  function match(items, query) {
    var needle = query.toLowerCase();
    var exact = [];
    var prefix = [];
    var contains = [];

    for (var i = 0; i < items.length; i++) {
      var name = items[i].name;
      var lower = name.toLowerCase();
      if (lower === needle) {
        exact.push(items[i]);
      } else if (lower.indexOf(needle) === 0) {
        prefix.push(items[i]);
      } else if (lower.indexOf(needle) > -1) {
        contains.push(items[i]);
      }
    }

    return exact.concat(prefix, contains).slice(0, MAX_RESULTS);
  }

  function readCache() {
    try {
      var raw = window.localStorage.getItem(CACHE_KEY);
      if (!raw) return null;

      var cached = JSON.parse(raw);
      if (!cached || !cached.items || !cached.items.length) return null;
      if (Date.now() - cached.time > CACHE_TTL) return null;

      var items = cached.items;
      for (var i = 0; i < items.length; i++) {
        if (!items[i] || typeof items[i].name !== 'string' ||
            typeof items[i].dir !== 'string') {
          return null;
        }
      }
      return items;
    } catch (error) {
      return null;
    }
  }

  function writeCache(items) {
    try {
      window.localStorage.setItem(CACHE_KEY, JSON.stringify({
        time: Date.now(),
        items: items
      }));
    } catch (error) {
      // 隐私模式或配额不足时忽略，内存索引仍然可用
    }
  }

  /* ------------------------------------------------------------------------
     将 nginx autoindex 的 <pre> 列表转换为现代文件表格
     ------------------------------------------------------------------------ */

  var table = document.querySelector('.file-table');
  if (!table) return;

  var pre = table.querySelector('pre');
  if (!pre) return;

  // 读取 autoindex 标题（如 "Index of /pool/"），用于卡片头部的路径
  var heading = table.querySelector('h1');
  var path = '/';
  if (heading) {
    var m = heading.textContent.match(/Index of\s+(.*)/i);
    if (m) path = m[1].trim();
    heading.remove();
  }

  var pathEl = document.getElementById('file-path');
  if (pathEl) pathEl.textContent = path;

  var rows = [];
  var lines = pre.innerHTML.split('\n');
  for (var i = 0; i < lines.length; i++) {
    var line = lines[i];
    if (!line.trim()) continue;

    var tmp = document.createElement('div');
    tmp.innerHTML = line;
    var link = tmp.querySelector('a');
    var name = link ? link.textContent : tmp.textContent;
    var href = link ? link.getAttribute('href') : '#';

    var rest = '';
    if (link) {
      var node = link.nextSibling;
      while (node) {
        if (node.textContent) rest += node.textContent;
        node = node.nextSibling;
      }
    }

    var parts = rest.trim().split(/\s+/).filter(Boolean);
    var date = parts.slice(0, 2).join(' ');
    var size = parts.slice(2).join(' ');

    rows.push({ name: name, href: href, date: date, size: size });
  }

  var list = document.createElement('div');
  list.className = 'file-list';

  var header = document.createElement('div');
  header.className = 'file-row file-header';
  header.innerHTML = '<span aria-hidden="true"></span>' +
                     '<span class="file-name">名称</span>' +
                     '<span class="file-date">修改时间</span>' +
                     '<span class="file-size">大小</span>';
  list.appendChild(header);

  for (var j = 0; j < rows.length; j++) {
    var r = rows[j];
    var row = document.createElement('a');
    row.className = 'file-row';
    row.setAttribute('href', r.href);
    row.innerHTML = '<span class="file-icon" aria-hidden="true"></span>' +
                    '<span class="file-name"></span>' +
                    '<span class="file-date"></span>' +
                    '<span class="file-size"></span>';
    row.querySelector('.file-name').textContent = r.name;
    row.querySelector('.file-date').textContent = r.date;
    row.querySelector('.file-size').textContent = r.size;
    list.appendChild(row);
  }

  pre.replaceWith(list);
})();
