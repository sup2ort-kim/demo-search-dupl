
/*페이지상단

$(document).ready(function() {
    $("body").append("<a class='return_top' href='#'><img src='../images/common/top_arrow.png'></a>");
    var top = $(".return_top");
    $(window).scroll(function () {
        if ($(this).scrollTop() > 120) {
            top.slideDown();
        }else {
            top.slideUp();        
        }
    });
    top.click(function () {
        $('body,html').animate({ scrollTop:0 },500);return false;})
        .css({
        "right":"20px",
        "bottom":"100px",
        "padding":"7px",
        "color":"#000",
        "background":"none",		
        "border-radius":"0%",
        "position":"fixed",
        "z-index":"9999" })
        .hide()
        .hover(function() { $(this).css({"background":"none"}) },
                     function() { $(this).css({"background":"none"}) }
                    );
});   
 */

/*페이지상단 수정*/

	$(function() {
		$(window).scroll(function() {
            if ($(this).scrollTop() > 50) {
                $('#page_top').fadeIn();
                $('#page_top').addClass('active')
            } else {
                $('#page_top').fadeOut();
                $('#page_top').removeClass('active')
            }
        });
		
        $("#top_btn").click(function() {
            $('html, body').animate({
                scrollTop : 0
            }, 500);
            return false;
        });
    });







/* 전체메뉴 */
var open_yn = false;
$(document).ready(function() {
    $(".allmenu .allmenu_toggle").click(function() {
        if (!open_yn) {
            open_yn = true;
            $("#header #allmenu_layer").stop().fadeIn(400, 'easeInOutCubic');
            $(this).addClass("active");
            $("#wrap").addClass("active");
        } else {
            open_yn = false;
            $("#header #allmenu_layer").stop().fadeOut(400, 'easeInOutCubic');
            $(".allmenu .allmenu_toggle").removeClass("active");
        }
    });

    $("#header #allmenu_layer .allmenu_close").click(function() {
        open_yn = false;
        $("#header #allmenu_layer").stop().fadeOut(400, 'easeInOutCubic');
        $(".allmenu .allmenu_toggle").removeClass("active");
        $("#wrap").removeClass("active");
    });
});


/* GNB */
$(function() {
    var gnbLi = $(".gnb_menu > li");
    var ul = $(".gnb_menu > li > ul");
    var headerMin = $("#gnb").height();
    var headerMax = ul.innerHeight() + headerMin;
    var state = false;
    var speed = 0;
    gnbLi.on("mouseenter keyup", function() {
        if (!state) {
            $("#gnb").stop().animate({
                height: headerMax
            }, speed, function() {
                ul.stop().fadeIn(speed);
            });
            state = true;
        }
        ul.removeClass("active");
        $(this).find("ul").addClass("active");
    });
    gnbLi.mouseleave(function() {
        $(this).find("ul").removeClass("active");
    });
    $(".gnb_inner").mouseleave(function() {
        ul.stop().fadeOut(speed, function() {
            $("#gnb").stop().animate({
                height: headerMin
            }, speed);
        });
        state = false;
    });
    $(".gnb_inner .close").focus(function() {
        ul.stop().fadeOut(speed, function() {
            $("#gnb").stop().animate({
                height: headerMin
            }, speed);
        });
        state = false;
    });
});


/*datepicker*/
  $( function() {
    $( "#datepicker" ).datepicker();
  } );
  
 

  $( function() {
    $( ".hasDaepicker" ).datepicker();
  } );
  

    
/*패싯네비*/
    $(document).ready(function(){       
        $(".fc_menu>h3").click(function(){
            var submenu = $(this).next("ul");
            if( submenu.is(":visible") ){
                submenu.slideUp();
            }else{
                submenu.slideDown();
            }
        });
    });


  
	
	/*탭*/	
 $(function () {	
	tab('#tab',0);	
});

function tab(e, num){
    var num = num || 0;
    var menu = $(e).children();
    var con = $(e+'_con').children();
    var select = $(menu).eq(num);
    var i = num;

    select.addClass('on');
    con.eq(num).show();

    menu.click(function(){
        if(select!==null){
            select.removeClass("on");
            con.eq(i).hide();
        }

        select = $(this);	
        i = $(this).index();

        select.addClass('on');
        con.eq(i).show();
    });
}








var w;
var pWidth, pHeight, pTop, pLeft, ww;
var setWidth, setHeight, setLeft, setTop;

$(document).ready(function() {
	/* GNB 메뉴 마우스, 키보드 이벤트(마우스오버, 키보드 탭 버튼 이동) */
	$(".gnb_ul > li").each(function(idx){
		$(this).bind({
			"mouseenter focusin":function(){
				$("#header").addClass("on");
				$(".gnb_ul > li").removeClass('active');
				$(this).addClass('active');
				$('.subdepth').removeClass('show_menu');
				$(this).find('.subdepth').stop().slideDown(200, function(){
					$(this).addClass('show_menu');
				});
			},
			"mouseleave focusout":function(){
				$("#header").removeClass("on");
				$(".gnb_ul > li").removeClass('active');
				$(this).find('.subdepth').stop().slideUp(100, function(){
					$(this).addClass('show_menu');
				});
			}
		});
	});
});


/*dep3*/
$(document).ready(function () {

    $(".dep03_ul > li > a.have_menu").click(function () {

        /*$(".dep03_ul > li > a.have_menu").removeClass('active');*/
        $(this).toggleClass('active');
    });

});


/*전체메뉴 모바일*/
    // html dom 이 다 로딩된 후 실행된다.
    $(document).ready(function(){
        // memu 클래스 바로 하위에 있는 a 태그를 클릭했을때
        $(".menu>a").click(function(){
            // 현재 클릭한 태그가 a 이기 때문에
            // a 옆의 태그중 ul 태그에 hide 클래스 태그를 넣던지 빼던지 한다.
            $(this).next("ul").toggleClass("hide");
        });
    });
  
  
/*모바일 dep3*/
function dropMenu(obj){
	$(obj).each(function(){
		var theSpan = $(this);
		var theMenu = theSpan.find(".submenu");
		var tarHeight = theMenu.height();
		theMenu.css({height:0,opacity:0});
		theSpan.hover(
			function(){
				$(this).addClass("selected");
				theMenu.stop().slideDown().animate({height:tarHeight,opacity:1},250);
			},
			function(){
				$(this).removeClass("selected");
				theMenu.stop().animate({height:0,opacity:0},250,function(){
					$(this).css({display:"none"});
				});
			}
		);
	});


}

$(document).ready(function(){
	
	dropMenu(".drop-menu-effect");
	

});


/*이전 버전 디자인 적용*/
    $(document).on("click", "#popup_btn", function () {
        $(".popup").addClass("on");
    });
    $(document).on("click", ".popup .btn_close", function () {
        $(".popup").removeClass("on");
    });
    $(document).on("click", ".btn_sort", function () {
        $(this).toggleClass("on");
        var txt = $(this).text();
        if (txt == '') {
            $(this).text("");
        } else {
            $(this).imtextg("");
        }
        return false;
    });

    $(document).on("click", ".btn_sort2", function () {
        $(this).toggleClass("on");
        var txt = $(this).text();
        if (txt == '') {
            $(this).text("");
        } else {
            $(this).imtextg("");
        }
        return false;
    });


    $(".input_file .file").on("change", function () {
        var file_name = $(this).val().replace(/.*(\/|\\)/, '');
        $(".input_file .file + label").eq($(this).index()).text(file_name);

    });

	/* header 유틸리티 */
    (function($) {
        $(document).ready(function() {
            $('.data_select > ul > li > button').click(function() {
                $('.data_select li').removeClass('active');
                $(this).closest('li').addClass('active');
                var checkElement = $(this).next();
                if ((checkElement.is('.drop_open')) && (checkElement.is(':visible'))) {
                    $(this).closest('li').removeClass('active');
                    checkElement.slideUp(400, 'easeInOutCubic');
                }
                if ((checkElement.is('.drop_open')) && (!checkElement.is(':visible'))) {
                    $('.data_select  ul .drop_open:visible').slideUp(400, 'easeInOutCubic');
                    checkElement.slideDown(400, 'easeInOutCubic');
                }
                if ($(this).closest('li').find('.drop_open').children().length == 0) {
                    return true;
                } else {
                    return false;
                }
            });
        });
    })(jQuery);

    




/*검색*/
    $(document).ready(function () {

        /* header 상단 이벤트 */       
        $(".btn_search").click(function () {
            $("#wrap").removeClass("").addClass("search_on");
        });
        $(".search_close").click(function () {
            $("#wrap").removeClass('search_on');
            return false;
        });
    
        /* 전체메뉴 관련 이벤트 */
        $("").click(function () {
            $("").removeClass("search_on").addClass("");
        });
        $("").click(function () {
            $("#wrap").removeClass('');
            return false;
        });    
    
       
    
    });


    /* location */
    (function($) {
        $(document).ready(function() {
            $('.loca_dep1 > ul > li > button').click(function() {
                $('.loca_dep1 li').removeClass('active');
                $(this).closest('li').addClass('active');
                var checkElement = $(this).next();
                if ((checkElement.is('.drop_open')) && (checkElement.is(':visible'))) {
                    $(this).closest('li').removeClass('active');
                    checkElement.slideUp(400, 'easeInOutCubic');
                }
                if ((checkElement.is('.drop_open')) && (!checkElement.is(':visible'))) {
                    $('.loca_dep1  ul .drop_open:visible').slideUp(400, 'easeInOutCubic');
                    checkElement.slideDown(400, 'easeInOutCubic');
                }
                if ($(this).closest('li').find('.drop_open').children().length == 0) {
                    return true;
                } else {
                    return false;
                }
            });
        });
    })(jQuery);

   

      /* path 이벤트 */
    function dp_menu(){
        let click = document.getElementById("drop-content");
        if(click.style.display === "none"){
            click.style.display = "block" ;          

        }else{
            click.style.display = "none";          

        }
    }

    function dp_menu2(){
        let click = document.getElementById("drop-content2");
        if(click.style.display === "none"){
            click.style.display = "block";         

        }else{
            click.style.display = "none";           

        }
    }


/* 공유 */
    function myFunction() {
        document.getElementById("myDropdown").classList.toggle("show");
    }
 
    window.onclick = function(event) {
      if (!event.target.matches('.dropbtn')) {
    
        var dropdowns = document.getElementsByClassName("dropdown-content");
        var i;
        for (i = 0; i < dropdowns.length; i++) {
          var openDropdown = dropdowns[i];
          if (openDropdown.classList.contains('show')) {
            openDropdown.classList.remove('show');
          }
        }
      }
    }

    
/* 공유 */
function myFunction2() {
    document.getElementById("myDropdown2").classList.toggle("show");
}

window.onclick = function(event) {
  if (!event.target.matches('.dropbtn2')) {

    var dropdowns = document.getElementsByClassName("dropdown-content2");
    var i;
    for (i = 0; i < dropdowns.length; i++) {
      var openDropdown = dropdowns[i];
      if (openDropdown.classList.contains('show')) {
        openDropdown.classList.remove('show');
      }
    }
  }
}


  
   /*datepicker*/
  $( function() {
    $( "#datepicker" ).datepicker();
  } );
  
 

  $( function() {
    $( ".hasDaepicker" ).datepicker();
  } );
  


  /* 조회설정 */
    $(document).ready(function(){       
        $(".counti_op>a").click(function(){
            var submenu = $(this).next("ul");  
           
            if( submenu.is(":visible") ){
                submenu.slideUp();
            }else{
                submenu.slideDown();
            }
        });
    });



