console.log('如果调整浏览器窗口大小而导致的 ‘入门’ 和 ‘新闻‘ 两个板块的高度不对， 请刷新你的页面 -_-!!! ')
var contents = document.getElementById('mainContent').children[2].children;
console.log( contents)
window.onload = window.onresize = window.onscroll = function(){
	if( window.innerWidth >= 800 && contents[0].className === 'forTheFirstTime' && contents[1].className === 'secureUpdates' ){
		contents[0].offsetHeight > contents[1].offsetHeight
			? contents[1].style.height = contents[0].offsetHeight - 40 + 'px'
			: contents[0].style.height = contents[1].offsetHeight - 40 + 'px';
	}
}

// 设置手机界面点击显示按钮
var friendLinkBtn = document.getElementById('friendLinkBtn');
friendLinkBtn.onclick = function(){
	
}