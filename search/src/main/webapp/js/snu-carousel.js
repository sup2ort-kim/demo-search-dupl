

/* 메인 배너 */
$(document).on('ready', function() {
    $('#mbanner_carousel').slick({
        infinite:true,
        slidesToShow:5,
        slidesToScroll:1,
        speed:900,
        touchMove:false,
        cssEase:'cubic-bezier(0.7, 0, 0.3, 1)',
        touchThreshold:100,
        dots:false,
        arrows:true,
        autoplay:true,
        autoplaySpeed:5000,
        accessibility:false,
        responsive: [
            {
                breakpoint: 1000,
                settings: {slidesToShow:3, slidesToScroll:3}
            },
            {
                breakpoint: 800,
                settings: {slidesToShow:3, slidesToScroll:3, arrows:false}
            },
            {
                breakpoint: 640,
                settings: {slidesToShow:2, slidesToScroll:2, arrows:false}
            },
            {
                breakpoint: 440,
                settings: {slidesToShow:1, slidesToScroll:1, arrows:false}
            }
          ]
    });

    $('.mbanner .btn_pause').on('click', function(){
        var $pauseBtn = $(this);
        if ($pauseBtn.hasClass('paused')){
            $("#mbanner_carousel").slick('slickPlay');
            $pauseBtn.removeClass('paused');
        } else {
            $("#mbanner_carousel").slick('slickPause');
            $pauseBtn.addClass('paused');
        }
    });



    
});


