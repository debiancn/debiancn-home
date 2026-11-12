/* ==========================================================================
   Debian 中文软件仓库 — repo.js
   将 nginx autoindex 的 <pre> 列表转换为现代文件表格
   ========================================================================== */
(function () {
  'use strict';

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
