
$(document).ready(function() {

	"use strict";
	$(window).load(function () {
		$(".loaded").fadeOut();
		$(".preloader").delay(1000).fadeOut("slow");
	}); 
    /*---------------------------------------------*
     * Mobile menu
     ---------------------------------------------*/
    $('.navbar-collapse').find('a[href*=#]:not([href=#])').click(function () {
        if (location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') && location.hostname == this.hostname) {
            var target = $(this.hash);
            target = target.length ? target : $('[name=' + this.hash.slice(1) + ']');
            if (target.length) {
                $('html,body').animate({
                    scrollTop: (target.offset().top - 40)
                }, 1000);
                if ($('.navbar-toggle').css('display') != 'none') {
                    $(this).parents('.container').find(".navbar-toggle").trigger("click");
                }
                return false;
            }
        }
    });


/*-- =============================================== -->
<!-- ========== bootstrap scrollspy ========== -->
<!-- =============================================== --> */
    
    
    $('body').scrollspy({
    	target: '.navbar',
    	offset: 160
    });



/*<!-- =============================================== -->
<!-- ========== scrollTop.js ========== -->
<!-- =============================================== -->*/

    $(window).scroll(function(){
        if ($(this).scrollTop() > 600) {
            $('.scrollup').fadeIn('slow');
        } else {
            $('.scrollup').fadeOut('slow');
        }
    });
    $('.scrollup').click(function(){
        $("html, body").animate({ scrollTop: 0 }, 1000);
        return false;
    });



/*<!-- =============================================== -->
<!-- ========== scrolldown.js ========== -->
<!-- =============================================== -->*/

$('.scrolldown a').bind('click', function () {
    $('html , body').stop().animate({
        scrollTop: $($(this).attr('href')).offset().top - 160
    }, 1500, 'easeInOutExpo');
    event.preventDefault();
});


/*<!-- =============================================== -->
<!-- ========== navbardown.js ========== -->
<!-- =============================================== -->*/

$('.nav a').bind('click', function () {
    $('html , body').stop().animate({
        scrollTop: $($(this).attr('href')).offset().top -0
    }, 1500, 'easeInOutExpo');
    event.preventDefault();
});






/*<!-- =============================================== -->
<!-- ========== fancy box ========== -->
<!-- =============================================== -->*/



//
//	$(".youtube-media").on("click", function(e) {
//		var jWindow = $(window).width();
//		if (jWindow <= 410) {
//			return;
//		}
//		$.fancybox({
//			href: this.href,
//			padding: 4,
//			type: "iframe",
//			'href': this.href.replace(new RegExp("watch\\?v=", "i"), 'v/'),
//		});
//		return false;
//	});



/*<!-- =============================================== -->
<!-- ========== portfolio section ========== -->
<!-- =============================================== -->*/



$('#portfolio a').nivoLightbox({
	effect: 'fadeScale'
});



/*<!-- =============================================== -->
<!-- ========== owlcarousel team ========== -->
<!-- =============================================== -->*/



	
	$(".gallery_carousel").owlCarousel({

		/*autoPlay: 3000, //Set AutoPlay to 3 seconds*/
		items : 4,
		itemsDesktop : [1199,3],
		itemsDesktopSmall : [979,3],

		pagination : true,
		paginationNumbers: false,


		responsive: true,
		responsiveRefreshRate : 200,
		responsiveBaseWidth: window

	});



	$(".main_testimonial_text").owlCarousel({

	/*autoPlay: 3000, //Set AutoPlay to 3 seconds*/
	items :1,
	itemsDesktop : [1199,3],
	itemsDesktopSmall : [979,3],
	pagination : true,
	paginationNumbers: false,
	singleItem:true,
	responsive: true,
	responsiveRefreshRate : 200,
	responsiveBaseWidth: window

	});


 new WOW().init();

}); 






//<!-- =============================================== -->
//<!-- ========== Navbar ========== -->
//<!-- =============================================== -->


	jQuery(window).scroll(function () {
	  var top = jQuery(document).scrollTop();
		var batas = 800;
                var logo = 'images/logo.png';
                var logoScroll = 'images/logo.png';
	  //alert(batas);
	  
	  if (top > batas) {
		jQuery('.main-menu').addClass('tiny');
		jQuery('.main-menu').css('opacity','1');
        jQuery('.navbar-brand img').attr('src',logoScroll);
	  } else {
	   jQuery('.main-menu').removeClass('tiny'); 
        jQuery('.navbar-brand img').attr('src',logo);
	  }
	});


//
