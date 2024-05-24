//---------------------------------------- main -------------------------------------------
   
    // top right menu 로그인 클릭 시 하위메뉴
    $(document).ready(function(){
        // menu 클래스 바로 하위에 있는 a 태그를 클릭했을때
        $(".menu>a").click(function(){
            var submenu = $(this).next("div");

            // submenu 가 화면상에 보일때는 위로 보드랍게 접고 아니면 아래로 보드랍게 펼치기
            if( submenu.is(":visible") ){
                submenu.slideUp();
            }else{
                submenu.slideDown();
            }
        });
    });


       // top right menu 로그인 클릭 시 하위메뉴(도움말)
       $(document).ready(function(){
        // menu 클래스 바로 하위에 있는 a 태그를 클릭했을때
        $(".menu2>a").click(function(){
            var submenu = $(this).next("div.sub2");

            // submenu 가 화면상에 보일때는 위로 보드랍게 접고 아니면 아래로 보드랍게 펼치기
            if( submenu.is(":visible") ){
                submenu.hide();
            }else{
                submenu.show();
            }
        });
    });


    // top right menu 로그인 클릭 시 하위메뉴(도움말)
           $(document).ready(function(){
            // menu 클래스 바로 하위에 있는 a 태그를 클릭했을때
            $(".menu2>a.mb_block").click(function(){
                var submenu = $(this).next("div.m_sub2");
    
                // submenu 가 화면상에 보일때는 위로 보드랍게 접고 아니면 아래로 보드랍게 펼치기
                if( submenu.is(":visible") ){
                    submenu.hide();
                }else{
                    submenu.show();
                }
            });
        });

    // 로그인 버튼 변경 
    $(document).ready(function(){
    $('.menu>a').click(function(){ //공통되는 함수
        if($('.im').hasClass("xi-angle-down-min")) {
          $('.im').removeClass('xi-angle-down-min').addClass('xi-angle-up-min');
        } else {
          $('.im').removeClass('xi-angle-up-min').addClass('xi-angle-down-min');
        }
      })
    });



    // 인기검색어 마우스 오버 시 화면 
    $(document).ready(function(){
        $(".search_wrod").click(function(){	// 2024.02.23 마우스오버에서 클릭시 나타나는 것으로 변경
            $(this).find(".sub_menu").stop().slideDown(500);
        });
        $(".search_wrod").mouseleave(function(){
            $(this).find(".sub_menu").stop().slideUp(500); 
        }); 
     });

  
    
    //  main 탭 메뉴
    $(document).ready(function(){
        $('ul.tabs1 li').click(function(){
        var tab_id = $(this).attr('data-tab');

        $('ul.tabs1 li').removeClass('current');
        $('.tab-content1-2').removeClass('current');

        $(this).addClass('current');
        $("#"+tab_id).addClass('current');
        })
    });
            

    //  sub - 추천검색결과 상단 탭
    $(document).ready(function(){
        $('ul.search_tab li').click(function(){
        var tab_id = $(this).attr('data-tab');

        $('ul.search_tab li').removeClass('current');
        $('.tab_content1').removeClass('current');

        $(this).addClass('current');
        $("#"+tab_id).addClass('current');
        })
    });

    //  sub - 추천검색결과 하단 탭
    $(document).ready(function(){
        $('ul.search_s_tab li').click(function(){
        var tab_id = $(this).attr('data-tab');

        $('ul.search_s_tab li').removeClass('current');
        $('.tab_content2').removeClass('current');

        $(this).addClass('current');
        $("#"+tab_id).addClass('current');
        })
    });




    // like snu home slide5 
    $(document).ready(function(){
        $('.slide5_play').slick({
            slidesToShow: 5,
            slidesToScroll: 1,
            autoplay: false,
            autoplaySpeed: 4000,
            responsive: [
                {
                breakpoint: 1280, //화면이 1280 이상일때
                settings: {
                    arrows: true,
                    slidesToShow: 4,
                    slidesToScroll: 1,
                    variableWidth: true,
                    centerMode:false,
                }
                },
                {
                breakpoint: 1100, //화면이 1100 이상일때
                settings: {
                    arrows: true,
                    slidesToShow: 4,
                    slidesToScroll: 1,
                    variableWidth: true,
                    centerMode:false,
                }
                },
                {
                breakpoint: 992, //화면이 992 이상일때
                settings: {
                    arrows: true,
                    slidesToShow: 4,
                    slidesToScroll: 1,
                    variableWidth: true,
                    centerMode:false,
                }
                },
                {
                breakpoint: 768, //화면이 768 이상일때
                settings: {
                    arrows: true,
                    slidesToShow: 3,
                    slidesToScroll: 1,
                    variableWidth: true,
                    centerMode:false,
                }
                },
                {
                breakpoint: 480, //화면이 480 이상일때
                settings: {
                    arrows: true,
                    slidesToShow: 2,
                    slidesToScroll: 1,
                    variableWidth: true,
                    centerMode:false,
                }
                },
                {
                breakpoint: 340, //화면이 480 이상일때
                settings: {
                    arrows: true,
                    slidesToShow: 1,
                    slidesToScroll: 1,
                    variableWidth: true,
                    centerMode:false,
                }
                }
            ]
        });
    });




    // like snu home slide5 
    $(document).ready(function(){
        $('.slide4_play').slick({
            slidesToShow: 4,
            slidesToScroll: 1,
            autoplay: false,
            autoplaySpeed: 4000,
            responsive: [
                {
                breakpoint: 768,
                settings: {
                    arrows: true,
                    centerMode: false,
                    slidesToShow: 3,
                    slidesToScroll: 1,
                }
                },
                {
                breakpoint: 480,
                settings: {
                    arrows: true,
                    centerMode: false,
                    slidesToShow: 1,
                    slidesToScroll: 1,
                }
                },
                {
                breakpoint: 340,
                settings: {
                    arrows: true,
                    centerMode: false,
                    slidesToShow: 1,
                    slidesToScroll: 1,
                }
                }
            ]
        });
    });


    // like snu home slide3 
    $(document).ready(function(){
        $('.slide3_play').slick({
            slidesToShow: 3,
            slidesToScroll: 1,
            autoplay: false,
            autoplaySpeed: 4000,
            responsive: [
                {
                breakpoint: 1280,
                settings: {
                    arrows: true,
                    slidesToShow: 1,
                    slidesToScroll: 1,
                    variableWidth: true,
                    centerMode:false,
                }
                },
                {
                breakpoint: 768,
                settings: {
                    arrows: true,
                    slidesToShow: 1,
                    slidesToScroll: 1,
                    variableWidth: true,
                    centerMode:false,
                }
                },
                {
                breakpoint: 480,
                settings: {
                    arrows: true,
                    slidesToShow: 1,
                    slidesToScroll: 1,
                    variableWidth: true,
                    centerMode:false,
                }
                },
                {
                breakpoint: 340,
                settings: {
                    arrows: true,
                    slidesToShow: 1,
                    slidesToScroll: 1,
                    variableWidth: true,
                    centerMode:false,
                }
                }
            ]
        });
    });


    // like snu main3 - 도서 상단 메인 slide4 (auto)
    $(document).ready(function(){
        $('.slide45_play').slick({
            slidesToShow: 4,
            slidesToScroll: 1,
            autoplay: true,
            autoplaySpeed: 5000,
            responsive: [
                {
                breakpoint: 1280,
                settings: {
                    arrows: true,
                    slidesToShow: 4,
                    slidesToScroll: 1,
                    variableWidth: true,
                    centerMode: false,
                }
                },
                {
                breakpoint: 768,
                settings: {
                    arrows: true,
                    slidesToShow: 3,
                    slidesToScroll: 1,
                    variableWidth: true,
                    centerMode: false,
                }
                },
                {
                breakpoint: 480,
                settings: {
                    arrows: true,
                    slidesToShow: 1,
                    slidesToScroll: 1,
                    variableWidth: true,
                    centerMode: false,
                }
                }
            ]
        });
    });


    // like snu home card_box_slide3
    $(document).ready(function(){
        $('.card3_play').slick({
            slidesToShow: 3,
            slidesToScroll: 1,
            autoplay: false,
            centerMode:false,
            responsive: [
                {
                breakpoint: 1280,
                settings: {
                    arrows: true,
                    slidesToShow: 3,
                    slidesToScroll: 1,
                    centerMode:false,
                    variableWidth: true,
                }
                },
                {
                breakpoint: 768,
                settings: {
                    arrows: true,
                    slidesToShow: 3,
                    slidesToScroll: 1,
                    centerMode:false,
                    variableWidth: true,
                }
                },
                {
                breakpoint: 480,
                settings: {
                    arrows: true,
                    slidesToShow: 2,
                    slidesToScroll: 1,
                    centerMode:false,
                    variableWidth: true,
                }
                },
                {
                breakpoint: 340,
                settings: {
                    arrows: true,
                    slidesToShow: 1,
                    slidesToScroll: 1,
                    centerMode:false,
                    variableWidth: true,
                }
                }
            ]
        });
    });




    // like snu home card_box_slide6
    $(document).ready(function(){
        $('.card6_play').slick({
            slidesToShow: 6,
            slidesToScroll: 1,
            autoplay: false,
            autoplaySpeed: 4000,
            variableWidth:true,
            responsive: [
                {
                breakpoint: 768,
                settings: {
                    arrows: true,
                    centerMode: false,
                    slidesToShow: 3,
                    slidesToScroll: 1,
                }
                },
                {
                breakpoint: 480,
                settings: {
                    arrows: true,
                    centerMode: false,
                    slidesToShow: 1,
                    slidesToScroll: 1,
                }
                }
            ]
        });
    });



    
    // main2 - 주제 중간 슬라이드 그래프
    $(document).ready(function(){
        $('.class_3slide2').slick({
            slidesToShow: 3,
            slidesToScroll: 1,
            autoplay: false,
            autoplaySpeed: 5000,
            responsive: [
                {
                breakpoint: 1280,
                settings: {
                    arrows: true,
                    variableWidth: true,
                    centerMode:false,
                    slidesToShow: 3,
                    slidesToScroll: 1,
                }
                },
                {
                breakpoint: 768,
                settings: {
                    arrows: true,
                    variableWidth: true,
                    centerMode:false,
                    slidesToShow: 3,
                    slidesToScroll: 1,
                }
                },
                {
                breakpoint: 479,
                settings: {
                    arrows: true,
                    variableWidth: true,
                    centerMode:false,
                    slidesToShow: 2,
                    slidesToScroll: 1,
                }
                }
            ]
        });
    });



    // main4 - 논문 상단 메인 슬라이드3 (auto)
    $(document).ready(function(){
        $('.top_slide3_play').slick({
            slidesToShow: 3,
            slidesToScroll: 1,
            autoplay: true,
            autoplaySpeed: 5000,
            responsive: [
                {
                breakpoint: 1900,
                settings: {
                    arrows: true,
                    slidesToShow: 2,
                    slidesToScroll: 1,
                }
                },
                {
                breakpoint: 1280,
                settings: {
                    arrows: true,
                    slidesToShow: 2,
                    slidesToScroll: 1,
                }
                },
                {
                breakpoint: 768,
                settings: {
                    arrows: true,
                    slidesToShow: 2,
                    slidesToScroll: 1,
                }
                },
                {
                breakpoint: 530,
                settings: {
                    arrows: true,
                    slidesToShow: 1,
                    slidesToScroll: 1,
                }
                }
            ]
        });
    });



    // main4 - 논문 중간 메인 슬라이드(2023.12.27 추가)
    $(document).ready(function(){
        $('.thesis_3box').slick({
            slidesToShow: 2,
            slidesToScroll: 1,
            centerMode: false,
            variableWidth: true,
            autoplay: false,
            autoplaySpeed: 5000,
            responsive: [
                {
                breakpoint: 1280,
                settings: {
                    arrows: true,
                    centerMode: false,
                    variableWidth: true,
                    slidesToShow: 2,
                    slidesToScroll: 1,
                }
                },
                {
                breakpoint: 768,
                settings: {
                    arrows: true,
                    centerMode: false,
                    variableWidth: true,
                    slidesToShow: 2,
                    slidesToScroll: 1,
                }
                },
                {
                breakpoint: 480,
                settings: {
                    arrows: true,
                    centerMode: false,
                    variableWidth: true,
                    slidesToShow: 2,
                    slidesToScroll: 1,
                }
                }
            ]
        });
    });



    
    // main5 - 강의 상단 메인 슬라이드(auto) 2023.12.26 유지나 수정
    $(document).ready(function(){
        $('.class_3slide').slick({
            slidesToShow: 3,
            slidesToScroll: 1,
            autoplay: true,
            autoplaySpeed: 5000,
            responsive: [
                {
                breakpoint: 1280,
                settings: {
                    arrows: true,
                    centerMode: false,
                    slidesToShow: 2,
                    slidesToScroll: 1,
                }
                },
                {
                breakpoint: 768,
                settings: {
                    arrows: true,
                    centerMode: false,
                    slidesToShow: 2,
                    slidesToScroll: 1,
                }
                },
                {
                breakpoint: 480,
                settings: {
                    arrows: true,
                    centerMode: false,
                    slidesToShow: 1,
                    slidesToScroll: 1,
                }
                }
            ]
        });
    });

  

    //----------------------------------------- 주제 탭 슬라이드 시작 ---------------------------------------------

    // 탭 안에 슬릭 슬라이드2 - main2 주제(2024.01.09 추가)
    $(document).ready(function () {
        $('.tab_slider2 button').click(function(){
            var $this = $(this);
            var index = $this.index();
            
            $this.addClass('active');
            $this.siblings('button.active').removeClass('active');
            
            var $outer = $this.closest('.outer');
            var $current = $outer.find(' > .tabs > .tab.active');
            var $post = $outer.find(' > .tabs > .tab').eq(index);
            
            $current.removeClass('active');
            $post.addClass('active');
            // 위의 코드는 탭메뉴 코드입니다.
            
            $('.slider2').slick('setPosition');
            $('.thesis_3box2').slick('setPosition');
            $('.class_3slide3').slick('setPosition');
            $('.likesnu_slider').slick('setPosition');
            // 탭 페이지 안에서 slick 사용시 – 
            // slick이 첫페이지에 있지 않으면 slick의 첫번째 이미지가 보이지 않고 2번째 부터 도는것을 확인 할 수 있다. 
            // 해당 문제는 탭이 active가 된 후 그 페이지에 slick이 있다면 = slick의 위치를 수동으로 새로 고쳐줘야 한다.
        });


        // 기존 처음의 slick 적용
        $('.slider2').slick({
            slidesToShow: 6,
            slidesToScroll: 1,
            autoplay: false,
            arrows: true,
            responsive: [
                {
                breakpoint: 1280,
                settings: {
                    arrows: true,
                    slidesToShow: 3,
                    slidesToScroll: 1,
                    variableWidth: true,
                    centerMode:false,
                }
                },
                {
                breakpoint: 768,
                settings: {
                    arrows: true,
                    slidesToShow: 3,
                    slidesToScroll: 1,
                    variableWidth: true,
                    centerMode:false,
                }
                },
                {
                breakpoint: 480,
                settings: {
                    arrows: true,
                    slidesToShow: 1,
                    slidesToScroll: 1,
                    variableWidth: true,
                    centerMode:false,
                }
                },
                {
                breakpoint: 340,
                settings: {
                    arrows: true,
                    slidesToShow: 1,
                    slidesToScroll: 1,
                    variableWidth: true,
                    centerMode:false,
                }
                }
            ]
        });//slider2
        $('.thesis_3box2').slick({
            slidesToShow: 3,
            slidesToScroll: 1,
            autoplay: false,
            autoplaySpeed: 5000,
            responsive: [
                {
                breakpoint: 1280,
                settings: {
                    arrows: true,
                    centerMode: false,
                    variableWidth: true,
                    slidesToShow: 3,
                    slidesToScroll: 1,
                }
                },
                {
                breakpoint: 768,
                settings: {
                    arrows: true,
                    centerMode: false,
                    variableWidth: true,
                    slidesToShow: 3,
                    slidesToScroll: 1,
                }
                },
                {
                breakpoint: 480,
                settings: {
                    arrows: true,
                    centerMode: false,
                    variableWidth: true,
                    slidesToShow: 2,
                    slidesToScroll: 1,
                }
                }
            ]
        });//논문
        $('.class_3slide3').slick({
            slidesToShow: 3,
            slidesToScroll: 1,
            autoplay: false,
            arrows: true,
            autoplaySpeed: 5000,
            responsive: [
                {
                breakpoint: 1280,
                settings: {
                    arrows: true,
                    slidesToShow: 3,
                    slidesToScroll: 1,
                    variableWidth: true,
                    centerMode:false,
                }
                },
                {
                breakpoint: 768,
                settings: {
                    arrows: true,
                    slidesToShow: 3,
                    slidesToScroll: 1,
                    variableWidth: true,
                    centerMode:false,
                }
                },
                {
                breakpoint: 480,
                settings: {
                    arrows: true,
                    slidesToShow: 1,
                    slidesToScroll: 1,
                    variableWidth: true,
                    centerMode:false,
                }
                }
            ]
        });//강의
        //LikeSNU
        $('.likesnu_slider').slick({
            slidesToShow: 4,
            slidesToScroll: 1,
            autoplay: false,
            arrows: true,
            autoplaySpeed: 5000,
            responsive: [
                {
                breakpoint: 1280,
                settings: {
                    arrows: true,
                    slidesToShow: 4,
                    slidesToScroll: 1,
                    variableWidth: true,
                    centerMode:false,
                }
                },
                {
                breakpoint: 1100,
                settings: {
                    arrows: true,
                    slidesToShow: 3,
                    slidesToScroll: 1,
                    variableWidth: true,
                    centerMode:false,
                }
                },
                {
                breakpoint: 768,
                settings: {
                    arrows: true,
                    slidesToShow: 2,
                    slidesToScroll: 1,
                    variableWidth: true,
                    centerMode:false,
                }
                },
                {
                breakpoint: 480,
                settings: {
                    arrows: true,
                    slidesToShow: 1,
                    slidesToScroll: 1,
                    variableWidth: true,
                    centerMode:false,
                }
                }
            ]
        });

    });


//--------------------------------------------- 주제 탭 슬라이드 끝 ----------------------------------------------------------
    


    // 탭 안에 슬릭 슬라이드1
    $(document).ready(function () {
        $('.tab_slider button').click(function(){
            var $this = $(this);
            var index = $this.index();
            
            $this.addClass('active');
            $this.siblings('button.active').removeClass('active');
            
            var $outer = $this.closest('.outer');
            var $current = $outer.find(' > .tabs .tab.active');
            var $post = $outer.find(' > .tabs .tab').eq(index);
            
            $current.removeClass('active');
            $post.addClass('active');
            // 위의 코드는 탭메뉴 코드입니다.
            
            $('.slider').slick('setPosition');
            // 탭 페이지 안에서 slick 사용시 – slick이 첫페이지에 있지 않으면 slick의 첫번째 이미지가 보이지 않고 2번째 부터 도는것을 확인 할 수 있다. 해당 문제는 탭이 active가 된 후 그 페이지에 slick이 있다면 = slick의 위치를 수동으로 새로 고쳐줘야 한다.
        });

        // 기존 처음의 slick 적용
        $('.slider').slick({
            slidesToShow: 3,
            slidesToScroll: 1,
            autoplay: false,
            autoplaySpeed: 4000,
            responsive: [
                {
                breakpoint: 1280,
                settings: {
                    arrows: true,
                    slidesToShow: 3,
                    slidesToScroll: 1,
                    variableWidth: true,
                    centerMode:false,
                }
                },
                {
                breakpoint: 768,
                settings: {
                    arrows: true,
                    slidesToShow: 3,
                    slidesToScroll: 1,
                    variableWidth: true,
                    centerMode:false,
                }
                },
                {
                breakpoint: 480,
                settings: {
                    arrows: true,
                    slidesToShow: 2,
                    slidesToScroll: 1,
                    variableWidth: true,
                    centerMode:false,
                }
                },
                {
                breakpoint: 340,
                settings: {
                    arrows: true,
                    slidesToShow: 1,
                    slidesToScroll: 1,
                    variableWidth: true,
                    centerMode:false,
                }
                }
            ]
        });
    });


    
    // 탭 안에 슬릭 슬라이드3 - sub5-2 강의 상세(연관도서 화면)
    $(document).ready(function () {
        $('.tab_slider3 button').click(function(){
            var $this = $(this);
            var index = $this.index();
            
            $this.addClass('active');
            $this.siblings('button.active').removeClass('active');
            
            var $outer = $this.closest('.outer');
            var $current = $outer.find(' > .tabs > .tab.active');
            var $post = $outer.find(' > .tabs > .tab').eq(index);
            
            $current.removeClass('active');
            $post.addClass('active');
            // 위의 코드는 탭메뉴 코드입니다.
            
            $('.slider3').slick('setPosition');
            // 탭 페이지 안에서 slick 사용시 – slick이 첫페이지에 있지 않으면 slick의 첫번째 이미지가 보이지 않고 2번째 부터 도는것을 확인 할 수 있다. 해당 문제는 탭이 active가 된 후 그 페이지에 slick이 있다면 = slick의 위치를 수동으로 새로 고쳐줘야 한다.
        });

        

        // 기존 처음의 slick 적용
        $('.slider3').slick({
            slidesToShow: 5,
            slidesToScroll: 1,
            autoplay: false,
            autoplaySpeed: 4000,
            responsive: [
                {
                breakpoint: 1280,
                settings: {
                    arrows: true,
                    slidesToShow: 4,
                    slidesToScroll: 1,
                    variableWidth: true,
                    centerMode:false,
                }
                },
                {
                breakpoint: 768,
                settings: {
                    arrows: true,
                    slidesToShow: 3,
                    slidesToScroll: 1,
                    variableWidth: true,
                    centerMode:false,
                }
                },
                {
                breakpoint: 480,
                settings: {
                    arrows: true,
                    slidesToShow: 2,
                    slidesToScroll: 1,
                    variableWidth: true,
                    centerMode:false,
                }
                },
                {
                breakpoint: 340,
                settings: {
                    arrows: true,
                    slidesToShow: 1,
                    slidesToScroll: 1,
                    variableWidth: true,
                    centerMode:false,
                }
                }
            ]
        });
    });





      
    // 탭 안에 슬릭 슬라이드3 - main5 강의 가운데 탭 슬라이드 추가(도서/논문) 보이도록
    $(document).ready(function () {
        $('.tab_slider4 button').click(function(){
            var $this = $(this);
            var index = $this.index();
            
            $this.addClass('active');
            $this.siblings('button.active').removeClass('active');
            
            var $outer = $this.closest('.outer');
            var $current = $outer.find(' > .tabs > .tab.active');
            var $post = $outer.find(' > .tabs > .tab').eq(index);
            
            $current.removeClass('active');
            $post.addClass('active');
            // 위의 코드는 탭메뉴 코드입니다.
            
            $('.slider4').slick('setPosition');
            // 탭 페이지 안에서 slick 사용시 – slick이 첫페이지에 있지 않으면 slick의 첫번째 이미지가 보이지 않고 2번째 부터 도는것을 확인 할 수 있다. 해당 문제는 탭이 active가 된 후 그 페이지에 slick이 있다면 = slick의 위치를 수동으로 새로 고쳐줘야 한다.
        });

        // 기존 처음의 slick 적용
        $('.slider4').slick({
            slidesToShow: 3,
            slidesToScroll: 1,
            autoplay: false,
            arrows: true,
            variableWidth: true,
            centerMode:false,
            responsive: [
                {
                breakpoint: 1280,
                settings: {
                    arrows: true,
                    slidesToShow: 3,
                    slidesToScroll: 1,
                    variableWidth: true,
                    centerMode:false,
                }
                },
                {
                breakpoint: 768,
                settings: {
                    arrows: true,
                    slidesToShow: 2,
                    slidesToScroll: 1,
                    variableWidth: true,
                    centerMode:false,
                }
                },
                {
                breakpoint: 480,
                settings: {
                    arrows: true,
                    slidesToShow: 2,
                    slidesToScroll: 1,
                    variableWidth: true,
                    centerMode:false,
                }
                },
                {
                breakpoint: 340,
                settings: {
                    arrows: true,
                    slidesToShow: 1,
                    slidesToScroll: 1,
                    variableWidth: true,
                    centerMode:false,
                }
                }
            ]
        });
    });



    

    // 탭 안에 슬릭 슬라이드3 - 강의검색 상세 중간 [연관논문] 탭 슬라이드 (2024.01.26 수정) 시작
    $(document).ready(function () {
        $('.tab_slider5 button').click(function(){
            var $this = $(this);
            var index = $this.index();
            
            $this.addClass('active');
            $this.siblings('button.active').removeClass('active');
            
            var $outer = $this.closest('.outer');
            var $current = $outer.find(' > .tabs > .tab.active');
            var $post = $outer.find(' > .tabs > .tab').eq(index);
            
            $current.removeClass('active');
            $post.addClass('active');
            // 위의 코드는 탭메뉴 코드입니다.
            
            $('.slide3_play2').slick('setPosition');
            // 탭 페이지 안에서 slick 사용시 – slick이 첫페이지에 있지 않으면 slick의 첫번째 이미지가 보이지 않고 2번째 부터 도는것을 확인 할 수 있다. 해당 문제는 탭이 active가 된 후 그 페이지에 slick이 있다면 = slick의 위치를 수동으로 새로 고쳐줘야 한다.
        });

        // 기존 처음의 slick 적용
        $('.slide3_play2').slick({
            slidesToShow: 3,
            slidesToScroll: 1,
            autoplay: false,
            autoplaySpeed: 4000,
            responsive: [
                {
                breakpoint: 1280,
                settings: {
                    arrows: true,
                    slidesToShow: 1,
                    slidesToScroll: 1,
                    variableWidth: true,
                    centerMode:false,
                }
                },
                {
                breakpoint: 768,
                settings: {
                    arrows: true,
                    slidesToShow: 1,
                    slidesToScroll: 1,
                    variableWidth: true,
                    centerMode:false,
                }
                },
                {
                breakpoint: 480,
                settings: {
                    arrows: true,
                    slidesToShow: 1,
                    slidesToScroll: 1,
                    variableWidth: true,
                    centerMode:false,
                }
                },
                {
                breakpoint: 340,
                settings: {
                    arrows: true,
                    slidesToShow: 1,
                    slidesToScroll: 1,
                    variableWidth: true,
                    centerMode:false,
                }
                }
            ]
        });
    });
    // 탭 안에 슬릭 슬라이드3 - 강의검색 상세 중간 [연관논문] 탭 슬라이드 (2024.01.26 수정) 끝


    


      // main3 - 도서 슬라이드 ... 더보기 아이콘 클릭1
      $(document).ready(function(){
        // menu 클래스 바로 하위에 있는 a 태그를 클릭했을때
        $(".more_view_btn1").click(function(){
			var submenu = $(this).next("ul.more_view_drop1");
			
			var classList = $('ul.more_view_drop1');
			for(var item of classList){
				if( item == submenu.get(0))
					continue
				
				item.style.display = 'none'
				
			}
			
            //var submenu = $(this).next("ul.more_view_drop1");

            // submenu 가 화면상에 보일때는 위로 보드랍게 접고 아니면 아래로 보드랍게 펼치기
            if( submenu.is(":visible") ){
                submenu.slideUp();
            }else{
                submenu.slideDown();
            }
        });
    });


     // main2 - 주제 탭 안에 ... 더보기 메뉴 버튼    
     $(document).ready(function(){
        // menu 클래스 바로 하위에 있는 a 태그를 클릭했을때
        $(".menu1>span").click(function(){
            var submenu = $(this).next("ul.sub1");

            var classList = $('ul.sub1');
			for(var item of classList){
				if( item == submenu.get(0))
					continue
				
				item.style.display = 'none'
				
			}
			

            // submenu 가 화면상에 보일때는 위로 보드랍게 접고 아니면 아래로 보드랍게 펼치기
            if( submenu.is(":visible") ){
                submenu.slideUp();
            }else{
                submenu.slideDown();
            }
        });
    });

       // main2 - 주제 탭 안에 ... 더보기 메뉴 버튼    
       $(document).ready(function(){
        // menu 클래스 바로 하위에 있는 a 태그를 클릭했을때
        $(".menu3>span").click(function(){
            var submenu = $(this).next("div.sub3");

            var classList = $('div.sub3');
			for(var item of classList){
				if( item == submenu.get(0))
					continue
				
				item.style.display = 'none'
				
			}

            // submenu 가 화면상에 보일때는 위로 보드랍게 접고 아니면 아래로 보드랍게 펼치기
            if( submenu.is(":visible") ){
                submenu.slideUp();
            }else{
                submenu.slideDown();
            }
        });
    });




   // click 탭 메뉴 변경
   $(document).ready(function () {
        $(".li_tit01").click(function(){
        $(".li_tit02,.li_tit03,.li_tit04,.li_tit05").css("padding-left", 29).css("padding-right", 29);
        });
        $(".li_tit01").click(function(){
            $(this).css("margin-right", 5);
        });
        $(".li_tit02").click(function(){
            $(".li_tit01").css("margin", 0);
            $(".li_tit01,.li_tit03,.li_tit04,.li_tit05").css("padding-left", 25).css("padding-right", 25);
        });
        $(".li_tit03").click(function(){
            $(".li_tit01").css("margin", 0);
            $(".li_tit01,.li_tit02,.li_tit04,.li_tit05").css("padding-left", 25).css("padding-right", 25);
        });
        $(".li_tit04").click(function(){
            $(".li_tit01").css("margin", 0);
            $(".li_tit01,.li_tit02,.li_tit03,.li_tit04,.li_tit05").css("padding-left", 25).css("padding-right", 25);
        });
        $(".li_tit05").click(function(){
            $(".li_tit01").css("margin", 0);
            $(".li_tit01,.li_tit02,.li_tit03,.li_tit04,.li_tit05").css("padding-left", 25).css("padding-right", 25);
        });
    });




// 셀렉트 박스 디자인
$(document).ready(function () {
    $(".select-box").click(function() {
        var select = $(this);
        
        //드롭다운 열기
        if (select.siblings('.select-box-dropDown').css('display') != 'block') {
        	select.addClass("open").next('.select-box-dropDown').slideDown(100).addClass("open");
		}
        
        //다른영역 클릭 시 닫기
        $(document).mouseup(function(e) {
        var seting = $(".select-box-dropDown");
        if (seting.has(e.target).length === 0) {
            seting.removeClass("open").slideUp(100);
            select.removeClass("open");
        }
        });
    
        $(".select-box-dropDown a").click(function() {
        var option = $(this).text();
        
        //클릭 시 드롭다운 닫기
        $(".select-box-dropDown a").removeClass('selected');
        $(".select-box-dropDown").removeClass("open").slideUp(100);
        select.removeClass("open");
        $(this).addClass('selected');
        
        //select에  text 넣기
        select.text(option);
        });
    });
});


// 셀렉트 박스 디자인
$(document).ready(function () {
    $(".select-box2").click(function() {
        var select = $(this);
        
        //드롭다운 열기
        select.addClass("open").next('.select-box2-dropDown').slideDown(100).addClass("open");
        
        //다른영역 클릭 시 닫기
        $(document).mouseup(function(e) {
        var seting = $(".select-box2-dropDown");
        if (seting.has(e.target).length === 0) {
            seting.removeClass("open").slideUp(100);
            select.removeClass("open");
        }
        });
    
        $(".select-box2-dropDown a").click(function() {
        var option = $(this).text();
        
        //클릭 시 드롭다운 닫기
        $(".select-box2-dropDown a").removeClass('selected');
        $(".select-box2-dropDown").removeClass("open").slideUp(100);
        select.removeClass("open");
        $(this).addClass('selected');
        
        //select에  text 넣기
        select.text(option);
        });
    });
});



// 셀렉트 박스 디자인
$(document).ready(function () {
    $(".select-box3").click(function() {
        var select = $(this);
        
        //드롭다운 열기
        select.addClass("open").next('.select-box3-dropDown').slideDown(100).addClass("open");
        
        //다른영역 클릭 시 닫기
        $(document).mouseup(function(e) {
        var seting = $(".select-box3-dropDown");
        if (seting.has(e.target).length === 0) {
            seting.removeClass("open").slideUp(100);
            select.removeClass("open");
        }
        });
    
        $(".select-box3-dropDown a").click(function() {
        var option = $(this).text();
        
        //클릭 시 드롭다운 닫기
        $(".select-box3-dropDown a").removeClass('selected');
        $(".select-box3-dropDown").removeClass("open").slideUp(100);
        select.removeClass("open");
        $(this).addClass('selected');
        
        //select에  text 넣기
        select.text(option);
        });
    });
});






/* sub 스크립트 -----------------------------------------*/




//top 버튼
$(document).ready(function () {
    $(window).scroll(function(){
    if($(this).scrollTop()>500){
    $('#top_btn').fadeIn();
    }else{
    $('#top_btn').fadeOut();
    }
    });
    
    $("#top_btn").click(function(){
    $('html,body').animate({
    scrollTop:0
    },400);
    returnfalse;
    });
});

//top 버튼
$(document).ready(function () {
    $(window).scroll(function(){
    if($(this).scrollTop()>500){
    $('.quickmenu').fadeIn();
    }else{
    $('.quickmenu').fadeOut();
    }
    });
});


//퀵 메뉴 열고
$( document ).ready(function() { 
    $('.quick_more_btn').click(function(){ 
     $('.quikmenu_open').show(); 
 }); 
 $('.quik_close_btn').click(function(e){ 
     e.preventDefault(); 
     $('.quikmenu_open').hide(); 
 }); 
});



//  sub quick menu 안에 탭 메뉴
//  sub - 추천검색결과 상단 탭
$(document).ready(function(){
    $('ul.quick_search_tab li').click(function(){
    var tab_id = $(this).attr('data-tab');

    $('ul.quick_search_tab li').removeClass('current');
    $('.quick_tab_content').removeClass('current');

    $(this).addClass('current');
    $("#"+tab_id).addClass('current');
    })
});


$(document).on("click", "#popup_btn", function () {
    $(".popup").addClass("on");
});
$(document).on("click", ".popup .btn_close", function () {
    $(".popup").removeClass("on");
});
$(document).on("click", ".btn_sort", function () {
    $(this).toggleClass("on");
    var txt = $(this).text();
    if (txt == '오름차순') {
        $(this).text("내림차순");
    } else {
        $(this).text("오름차순");
    }
    return false;
});
        


/* 리스트 타입 */
$(function() {
    $('.list_type ul li button').click(function() {
    var activeTab = $(this).attr('data-tab');
    $('.list_type ul li button').removeClass('active');
    $('.list_wrap .list_inner').removeClass('active');
    $(this).addClass('active');
    $('#' + activeTab).addClass('active');
    });
    });


 
/*메뉴고정*/
$(document).ready(function() {

	var menu = $( '.Head' ).offset();
		$( window ).scroll( function() {
			if ( $( document ).scrollTop() > menu.top ) {
				$( '.Head' ).addClass( 'fixed' );
			} else {
				$( '.Head' ).removeClass( 'fixed' );
			}
	});
});

	/* header 유틸리티 */
    (function($) {
        $(document).ready(function() {
            $('.data_select > ul > li > button').click(function() {
                $('.data_select li').removeClass('active');
                $(this).closest('li').addClass('active');
                var checkElement = $(this).next();
                if ((checkElement.is('.drop_open2')) && (checkElement.is(':visible'))) {
                    $(this).closest('li').removeClass('active');
                    checkElement.slideUp(400, 'easeInOutCubic');
                }
                if ((checkElement.is('.drop_open2')) && (!checkElement.is(':visible'))) {
                    $('.data_select  ul .drop_open2:visible').slideUp(400, 'easeInOutCubic');
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
