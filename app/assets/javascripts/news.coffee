$(document).on 'click', ".get_article_detail", ->
	title = $(this).data('title')
	author = $(this).data('author')
	publish_at = $(this).data('publish_at')
	desc = $(this).data('desc')
	img = $(this).data('img')
	url = $(this).data('url')
	sources = $(this).data('source')
	$.ajax
    type: "post"
    url: "/get_article"
    beforeSend: (xhr) ->
	    xhr.setRequestHeader 'X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')
	    return
    dataType: 'script'
    data: {title: title,author: author,publish_at: publish_at,desc: desc,img: img, url: url,source: sources}
  $('.customize-col-md-12').removeClass 'active-col-md-12'
  $(this).parents('.customize-col-md-12').addClass 'active-col-md-12'
  if $(window).width() < 767
	  $('.inbox-detail-scroll').fadeOut 300, ->
		  $('.view_article_details').fadeIn 300
		  return
  else


$(document).on 'click', ".get_news_api", ->
	type = $(this).data('type')
	$('.api_news_search').data('type',type)
	$('.get_news_api').removeClass('active-link')
	$(this).addClass('active-link')
	$('nav.mobile-side-menu').removeClass('active')
	$('.api_news_search').val("")
	$.ajax
		type: "post"
		url: "/get_overall_articles"
		dataType: 'script'
		data: {type: type}


$(document).on 'keyup', '.api_news_search', (e) ->
	val = $(this).val()
	type = $('.api_news_search').data("type")
	$.ajax
		type: "post"
		url: "/api_news_search"
		dataType: "script"
		data: {search: val,type: type}

$(document).on 'click', '.sent_news_api_link_btn', (e) ->
	link = $('.email_for_api_link').data('link')
	email = $('.email_api_input').val()
	if link != "" && email != ""
		$.ajax
			type: "post"
			url: "/email_for_api_link"
			dataType: "script"
			data: {link: link,email: email}
	else
		if email == ""
			$('.error_email_api').text("Email cannot be blank!")
			$('.email_api_input').addClass("error")
		if link == ""
			$('.error_email_api').text("Select the news, then only send the mail")
	$('.spin-image').show()

$(document).on 'click', '.email_for_api_link', (e) ->
	$('.fade-in-message').hide()
	$('.fade-out-message').show()


$(document).on 'keyup', ".email_api_input", (e) ->
	val = $(this).val()
	if isEmail(val)
		$('.error_email_api').text("")
		$('.email_api_input').removeClass("error")
	else
		$('.error_email_api').text("Invalid email address")
		$('.email_api_input').addClass("error")

isEmail = (email) ->
  regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/
  regex.test email