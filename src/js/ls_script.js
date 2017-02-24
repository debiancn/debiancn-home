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
}());
