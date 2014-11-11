ready = ->
  new WebsiteNav()

$(document).ready(ready)
#$(document).on('page:load', ready)

window.WebsiteNav = class WebsiteNav
  constructor: () ->

    jPM = $.jPanelMenu(
      menu: "#menu"
      trigger: ".menu-trigger"
      animated: false
      beforeOpen: (->
        $(".sidebar").css "left", "250px" if matchMedia("only screen and (min-width: 992px)").matches
      )
      beforeClose: (->
        $(".sidebar").css "left", "0"
        $(".writer-icon, .side-writer-icon").removeClass "fadeOutUp"
      )
    )
    jPM.on()

    $(".select-posts, .select-categories").on "click", ->
      $(".home-page-posts").toggleClass "hide"
      $(".home-page-categories").toggleClass "hide"
      $(".select-posts").toggleClass "active"
      $(".select-categories").toggleClass "active"
      $(".home-footer").toggleClass "hide"

    $(".writer-icon").on "click", ->
      $(this).addClass "fadeOutUp"

    fullHeight = $(window).height()
    $(".hero-image-404").css "height", fullHeight