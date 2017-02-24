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
/*	    $( '.menuList' ).hide();*/
	}
    }
    $( window ).bind( 'load', function(){
	topFixed();
    }).bind( 'scroll', function(){
	topFixed();
    }).bind( 'resize', function(){
	topFixed();
    });
}());
