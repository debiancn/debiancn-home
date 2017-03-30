(function(){
    /* 设置小屏幕设备 点击切换菜单栏 */
    $('.navMobiRight').bind( 'click', function(){
	$( '.menuList' ).toggle();
    } );
    /* 设置导航菜单 固定在页面最上方 */
    function topFixed(){
	if( window.innerWidth >= 700 && window.scrollY >= 63 ){
	    $('.menuListDiv').css({
		'position':'fixed',
		'top':'0',
		'left':'0'
	    });
	}else if( window.innerWidth >= 700 ){
	    $('.menuListDiv').css({
		'position':'relative',
		'top':'0',
		'left':'0'
	    });
	    $( '.menuList' ).show();
	}else if( window.innerWidth <= 700 ){
	    $('.menuListDiv').css({
		'position':'relative',
		'top':'0',
		'left':'0'
	    });
	}
    }
    $( window ).bind( 'load', function(){
	topFixed();
    }).bind( 'scroll', function(){
	topFixed();
    }).bind( 'resize', function(){
	topFixed();
    });
    /* 设置菜单栏三个a标签点击时切换页面显示内容 */
    $('.indexClick').on( 'click', function(){
	$('.mainContainer').hide();
	$('.layoutIndex').show();
    });
    $('.contactClick').on( 'click', function(){
	$('.mainContainer').hide();
	$('.layoutContact').show();
    });
    $('.donateClick').on( 'click', function(){
	$('.mainContainer').hide();
	$('.layoutDonate').show();
    });
    /* 默认设置显示第一个布局 */
    $('.mainContainer').hide();
    $('.layoutIndex').show();
    /* IE warning */
    if( navigator.appName === 'Microsoft Internet Explorer' && navigator.appVersion <= 4 ){
	$('.IEWarning').appendChild($('<div class="closeIEWarning"></div><p>Please update your IE browser, or install a <strong>Modern browser</strong> instead of the old IE browser which you are using now!</p><p><a href="https://www.microsoft.com/en-us/download/internet-explorer.aspx">This link is the Popular Internet Explorer downloads from Microsoft.</a></p><p><a href="https://www.google.cn/chrome/">This link is can help you get chrome for your computer</a>, but often slowly. <a href="https://www.google.com/chrome/">This link can be used for user with a international Internet connection.</a></p><p>Now, click this area to hide this warning.</p>'));
	$('.IEWarning').show();
	$('.closeIEWarning').one( 'click', function(){
	    $('.IEWarning').empty();
	});
    }
}());
