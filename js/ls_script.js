(function(){
    var Fixedflag = false;
    /* 设置小屏幕设备 点击切换菜单栏 */
    $('.navMobiRight').bind( 'click', function(){
	$( '.menuList' ).toggle();
    } );
    /* 设置导航菜单 固定在页面最上方 */
    $('.navigationContainer').height( $('.menuListDiv').height() );
    function topFixed(){
	if( !Fixedflag ){
	    console.log( Fixedflag );
	    Fixedflag = true;
	    setTimeout( function(){
		Fixedflag = false;
	    }, 1000/60 );
	    if( window.innerWidth >= 700 && window.scrollY >= 63 ){
		$('.menuListDiv').css({
		    'position':'fixed',
		    'top':'0',
		    'left':'0'
		});
//		$('.navigationContainer').height(0);
	    }else if( window.innerWidth >= 700 ){
		$('.menuListDiv').css({
		    'position':'relative',
		    'top':'0',
		    'left':'0'
		});
//		$('.navigationContainer').height( $('.menuListDiv').height() );
		$( '.menuList' ).show();
	    }else if( window.innerWidth <= 700 ){
		$('.menuListDiv').css({
		    'position':'relative',
		    'top':'0',
		    'left':'0'
		});
//		$('.navigationContainer').height( $('.menuListDiv').height() );
	    }
	}
    }
    $( window ).on( 'load', function(){
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

    /*修改新闻时间格式*/
    var _month = [
	['Jan','01'],
	['Feb','02'],
	['Mar','03'],
	['Apr','04'],
	['May','05'],
	['Jun','06'],
	['Jul','07'],
	['Aug','08'],
	['Sep','09'],
	['Oct','10'],
	['Nov','11'],
	['Dec','12'],
    ];
    $('.newsContainer .newsDate').each(function(){
	if( $(this).html().match(/,/) ){
	    $(this).html(
		(function( innerHTML ){
//		    console.log( innerHTML );
		    var _r = innerHTML.split(',')[1].split(" ");
		    for( let i in _month ){
			if( _month[i][0] === _r[2] ){
			    _r[2] = _month[i][1];
			    break;
			}
		    }
		    // 也可以返回和 安全更新 一样的格式， 这里的格式和之前的格式是一样的
		    // return _r[3] + '年' + _r[2] + '月' + _r[1] + '日';
		    return '[' +  _r[3] + '/' + _r[2] + '/' + _r[1] + ']';
		}( $(this).html() ))
	    );
	} else {
	    // 修改 ’2017年4月25‘ 格式 转换为 [2017/4/25]
	    $(this).html(
		(function( innerHTML ){
		    var _r = innerHTML.split('年');
		    _r[1] =_r[1].split('月');
		    _r[2] = _r[1][1].split('日')[0];
		    _r[1] = _r[1][0];
		    _r[1] = parseInt( _r[1] ) < 10 ? '0'+_r[1] : _r[1]; 
		    return '[' + _r[0] + '/' + _r[1] + '/' + _r[2] + ']';
		}( $(this).html() ))
	    );
    }
    });
}());
