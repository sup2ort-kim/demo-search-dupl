(function( $ ) {

	$(document).ready(function() {
		// Replace IMG to SVG
		$('img.img-to-svg').each(function() {
			var $img = jQuery(this),
				imgURL = $img.attr('src'),
				attributes = $img.prop("attributes");
	
			$.get(imgURL, function(data) {
				var $svg = jQuery(data).find('svg');
				$svg = $svg.removeAttr('xmlns:a');
				$.each(attributes, function() {
					$svg.attr(this.name, this.value);
				});
				$img.replaceWith($svg);
			}, 'xml');
		});
		
		$('#data-search-keyword').on('focusin', function(){
			$('#data-search').addClass('active');
		}).on('focusout', function(){
			$('#data-search').removeClass('active');
		});
		
		// Navigations
		var wpadminbar = $('#wpadminbar'),
			site_header = $('.site-header'),
			site_main = $('.site-main'),
			site_nav = $('#site-navigation'),
			site_nav_button = $('#site-nav-button'),
			primary_menu = $('#primary-menu-list'),
			primary_menu_item = $('#primary-menu-list > li > a'),
			site_search = $('#site-search'),
			site_search_button = $('#site-search-button'),
			site_search_close = $('#site-search-close'),
			user_menu = $('#user-menu'),
			user_login_button = $('#user-login-button'),
			help_menu = $('#help-menu'),
			site_footer = $('#site-footer'),
			footer_nav_bar = $('#footer-nav-bar'),
			footer_menu = $('#footer-menu'),
			sitemap_menu = $('#sitemap-menu'),
			footer_menu_button = $('#footer-menu-button'),
			sitemap_menu_button = $('#sitemap-menu-button'),
			sitemap_menu_button_2 = $('#sitemap-menu-button-2'),
			sidebar_menu = $('#sidebar-menu'),
			sidebar_menu_button = $('#sidebar-menu-button'),
			delay = 100,
			timer = null,
			breakpoint_lg = 992,
			breakpoint_md = 768;
			
		function toggleSiteNav(){
			site_nav.slideToggle();
			site_nav_button.toggleClass('active');
		}
		function closeSiteNav(){
			site_nav.slideUp();
			site_nav_button.removeClass('active');
		}
		function togglePrimarySubMenu(obj){
			var self = obj.closest('li'),
				siblings = self.siblings(),
				sub_menu = self.children('.sub-menu-container'),
				sub_menu_height = ( sub_menu.find('.sub-menu').outerHeight() ) + 'px',
				sibling_sub_menus = siblings.find('.sub-menu-container');
			siblings.removeClass('active');
			sibling_sub_menus.height('0px');
			if ($(window).width() >= breakpoint_lg) {
				sub_menu.height(sub_menu_height);
				self.addClass('active');
			} else {
				if ( self.hasClass('active') ) {
					sub_menu.height('0px');
				} else {
					sub_menu.height(sub_menu_height);
				}
				self.toggleClass('active');
			}
		}
		function closePrimarySubMenu(){
			primary_menu.find('.sub-menu-container').height('0px');
			primary_menu.children('li').removeClass('active');
		}
		function openSiteSearch(){
			site_search.fadeIn(100);
			site_search.find('.site-search-input').focus();
		}
		function closeSiteSearch(){
			site_search.fadeOut(100);
		}
		function toggleFooterMenu(){
			if ( sitemap_menu_button.hasClass('active') ) {
				sitemap_menu_button.removeClass('active');
				sitemap_menu_button_2.removeClass('active');
				closeSitemapMenu();
			}
			footer_menu.slideToggle();
			footer_menu_button.toggleClass('active');
		}
		function closeFooterMenu(){
			footer_menu.slideUp();
			footer_menu_button.removeClass('active');
		}
		function toggleSitemapMenu(){
			if ( footer_menu_button.hasClass('active') ) {
				footer_menu_button.removeClass('active');
				closeFooterMenu();
			}
			//sitemap_menu.slideToggle();
			sitemap_menu.slideToggle(500, function() {
				$(document).trigger('sitemapToggled');
			});
			sitemap_menu_button.toggleClass('active');
			sitemap_menu_button_2.toggleClass('active');
		}
		function closeSitemapMenu(){
			//sitemap_menu.slideUp();
			sitemap_menu.slideUp(500, function() {
				$(document).trigger('sitemapClosed');
			});
			sitemap_menu_button.removeClass('active');
			sitemap_menu_button_2.removeClass('active');
		}
		function openSitemapMenu(){
			//sitemap_menu.slideDown();
			sitemap_menu.slideDown(500, function() {
				$(document).trigger('sitemapOpened');
			});
			sitemap_menu_button.addClass('active');
			sitemap_menu_button_2.addClass('active');
		}
		function setHeaderMenuStatus() {
			if($(window).width() < breakpoint_lg) {
				help_menu.addClass('dropup').removeClass('dropdown');
				user_menu.addClass('dropup').removeClass('dropdown');
			} else {
				help_menu.addClass('dropdown').removeClass('dropup');
				user_menu.addClass('dropdown').removeClass('dropup');
			}
		}
		setHeaderMenuStatus();
		function toggleSidebarMenu(){
			sidebar_menu.toggleClass('active');
		}
		function openSidebarMenu(){
			sidebar_menu.addClass('active');
		}
		function closeSidebarMenu(){
			sidebar_menu.removeClass('active');
		}
		site_nav_button.on('click', function(){
			closePrimarySubMenu();
			toggleSiteNav();
		});
		primary_menu_item.on('click', function(e){
			var nextSibling = $(e.target).next();
    		if (nextSibling.is('.sub-menu-container')) {
				e.preventDefault();
				if ($(window).width() < breakpoint_lg) {
					togglePrimarySubMenu($(this));
				}
			}
		});
		primary_menu_item.on('mouseover', function(e){
			if ($(window).width() >= breakpoint_lg) {
				togglePrimarySubMenu($(this));
			}
		});
		primary_menu.on('mouseleave', function(e){
			if ($(window).width() >= breakpoint_lg) {
				closePrimarySubMenu();
			}
		});
		site_search_button.on('click', function(){
			openSiteSearch();
		});
		site_search_close.on('click', function(){
			closeSiteSearch();
		});
		footer_menu_button.on('click', function(){
			toggleFooterMenu();
		});
		sitemap_menu_button.on('click', function(){
			toggleSitemapMenu();
		});
		sitemap_menu_button_2.on('click', function(){
			if ( sitemap_menu_button_2.hasClass('active') ) {
				closeSitemapMenu();
			} else {
				openSitemapMenu();	
			}
		});
		user_login_button.on('click',function(){
			// 2023.04.24 추가 - SSO 로그인 체크 용도
			let returl = $("#modal-returl").val();
			let ssocheck = "/restapi/userinfo/?act=ssocheck&returl="+encodeURIComponent(returl);
			$.ajax({
				cache: false,
				async: true,
				type: 'get',
				dataType: 'jsonp',
				url: ssocheck,
				success: function(data) {
					if(data.result == true && data.ssoaction_url) {
						top.location.href = data.ssoaction_url;
						return false;
					}
				}
			});
			// 2023.04.24 추가 - 끝.

			if ( ! $('body').hasClass('logged-in') && $(window).width() < breakpoint_lg ) {
				closePrimarySubMenu();
				closeSiteNav();
			}
			// 2024.02.07 추가 모바일 화면에서 userId 클릭시 지식프로필로 이동
			if ( $('body').hasClass('logged-in') && $(window).width() < breakpoint_lg ) {
				window.location.href = '/usr/cmn/my/myKnowledgeProfile.do';
			}
		});
		sidebar_menu_button.on('click',function(){
			if ($(window).width() < breakpoint_lg) {
				toggleSidebarMenu();
			}
		});
		
		$(window).on('resize', function(){
			clearTimeout(timer);
			timer = setTimeout(function(){
				setHeaderMenuStatus();
			}, delay);
		});
		
		if( $('.page .entry-content').find('img').length > 0 ) {
			clearTimeout(timer);
			timer = setTimeout(function(){
				setHeaderMenuStatus();
			}, delay);
		}
		
		$(document).on('mouseup', function(e){
			if ($(e.target).closest(site_nav).length === 0 && $(e.target).closest(site_nav_button).length === 0){
				closePrimarySubMenu();
				if ($(window).width() < breakpoint_lg) {
					closeSiteNav();	
				}
			}
			if ($(e.target).closest(site_search).length === 0){
				closeSiteSearch();
			}
			if ($(e.target).closest(footer_menu).length === 0 && $(e.target).closest(footer_menu_button).length === 0 && $(e.target).closest(footer_nav_bar).length === 0){
				if ($(window).width() < breakpoint_lg) {
					closeFooterMenu();
				}
			}
			if ($(e.target).closest(sitemap_menu).length === 0 && $(e.target).closest(sitemap_menu_button).length === 0 && $(e.target).closest(footer_nav_bar).length === 0 && $(e.target).closest(sitemap_menu_button_2).length === 0){
				closeSitemapMenu();
			}
		});
		
		// Bootstrap toggle Tooltip
		$('[data-toggle="tooltip"]').tooltip();

		// Login modal
		setLoginModal();
		function setLoginModal() {
			var login_type = $(':radio[name="logintype"]:checked').val();
			if ( login_type == 'S' ) {
				$('.show-login-type-1').removeClass('d-none');
				$('.show-login-type-2').addClass('d-none');
			} else {
				$('.show-login-type-1').addClass('d-none');
				$('.show-login-type-2').removeClass('d-none');
			}
		}
		$('input[name=logintype]:radio').on('change',function () {
			setLoginModal();
		});
		
		// Custom input file
		$('.custom-file-input').each(function(){
			$(this).on('change', function(){
				var file_name = $(this).val().replace('C:\\fakepath\\', '');
				$(this).next('.custom-file-label').html(file_name);
			});
		});
		
		// Form validations
		$('form.needs-validation').each(function() {
			$(this).on('submit', function(e) {
				if ( $(this)[0].checkValidity() === false ) {
					e.preventDefault();
					e.stopPropagation();
				}
				$(this).addClass('was-validated');
			});
		});
		
		// Format Numbers
/*
		var cost = $('#cost'),
			amount = $('#amount');
			
		if(cost.length >= 1 ) {
			setNumberFormat(cost);
		}
		if(amount.length >= 1 ) {
			setNumberFormat(amount);
		}
		cost.on('input focusout', function (e) {
			setNumberFormat(cost);
		} );
		amount.on('input focusout', function (e) {
			setNumberFormat(amount);
		} );
*/
		
		var number_format = $('.number-format');
		if(number_format.length >= 1 ) {
			number_format.each(function(){
				setNumberFormat($(this));	
			});
			
		}
		number_format.on('focusout', function (e) {
			setNumberFormat($(this));
		} );

		function addCommas(x) {
			return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		}
		
		function setNumberFormat(obj){
			var str = obj.val();
			var res = addCommas(str);
			obj.val(res);
		}
		
		// Site search focus
		var site_search_form = $('.no-result-goto .search-form'),
			site_search_input = site_search_form.find('input[type=search]');
			
		site_search_input.focusin(function(){
			site_search_form.addClass('active');
		});
		
		site_search_input.focusout(function(){
			site_search_form.removeClass('active');
		});
		
		// Chosen
		if ($('.chosen-select').length > 0) $('.chosen-select').chosen({width: '100%'});
		
		// Confirm password
		$('.password-confirm[type=password]').on('input blur', function (e) {
			var el = $(this),
				val = el.val(),
				result = passwordConfirm(el),
				msg = '';
			for ( var i = 0 ; i < result['message'].length ; i ++ ) {
				msg += '<span>' + result['message'][i] + '</span>';
			}
			if ( result['check'] === true ) {
				el[0].setCustomValidity('');
				el.addClass('is-valid').removeClass('is-invalid');
				el.siblings('.valid-feedback').html(msg);
			} else {
				el[0].setCustomValidity("Invalid field.");
				el.addClass('is-invalid').removeClass('is-valid');
				el.siblings('.invalid-feedback').html(msg);
			}
		});
		function passwordConfirm(el) {
			var org = el.closest('form').find('.password-strength[type=password]').val(),
				val = el.val(),
				confirm = false,
				msg = [];
			if ( org == val && org !== '' ) {
				confirm = true;
				msg.push(messages.pw_msg_same);
			} else {
				confirm = false;
				msg.push(messages.pw_msg_different);
			}
			return {
				check: confirm,
				message: msg,
			};
		}
		
		// Check password strength
		$('.password-strength[type=password]').on('input blur', function (e) {
			var el = $(this),
				val = el.val(),
				result = passwordStrength(val),
				msg = '';
			for ( var i = 0 ; i < result['message'].length ; i ++ ) {
				msg += '<span>' + result['message'][i] + '</span>';
			}
			if ( result['check'] === true ) {
				el[0].setCustomValidity('');
				el.addClass('is-valid').removeClass('is-invalid');
				el.siblings('.valid-feedback').html(msg);
			} else {
				el[0].setCustomValidity("Invalid field.");
				el.addClass('is-invalid').removeClass('is-valid');
				el.siblings('.invalid-feedback').html(msg);
			}
		});
		function passwordStrength(val) {
			var strength = false,
				msg = [];
			if ( /^\s+$/.test(val) ) { // 공백으로 시작해도 되는건지 확인 필요, 공백이 포함될 수 없다면 /\s/ 로 변경해야 함
				strength = false;
				msg.push(messages.pw_msg_space);
				return {
			      check: strength,
			      message: msg,
			    };
			}
			val = val.replace(/^\s+|\s+$/g, '');
			if ( ! val.length || val.length < 9 ) {
				strength = false;
				msg.push(messages.pw_msg_length);
				return {
			      check: strength,
			      message: msg,
			    };
			}
			var upper = /[A-Z]/.test(val) | 0;
			var lower = /[a-z]/.test(val) | 0;
			var digit = /[0-9]/.test(val) | 0;
			var punctuation = /[`~!@#$%^&*()_+=\-|}{"?:><,./;'\\[\]]/.test(val) | 0;
			var count = upper + lower + digit + punctuation;
			if ( count < 3 ) {
				strength = false;
				if ( upper == 0 ) {
					msg.push(messages.pw_msg_upper);
				}
				if ( lower == 0 ) {
					msg.push(messages.pw_msg_lower);
				}
				if ( digit == 0 ) {
					msg.push(messages.pw_msg_digit);
				}
				if ( punctuation == 0 ) {
					msg.push(messages.pw_msg_punctuation);
				}
			} else {
				strength = true;
				msg.push(messages.pw_msg_success);
			}
			return {
				check: strength,
				message: msg,
			};
		}

		// Serach Result Status Dropdown : Prevent hiding dropdown menu when it clicked.
		$(document).on('click', '.dropdown-menu', function (e) {
			e.stopPropagation();
		  });
	
	}); // Document ready.
    
})( jQuery );