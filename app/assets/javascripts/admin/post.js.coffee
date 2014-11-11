ready = ->
  if $(".post")[0]

    toggle_static = ->
      if $("#post_is_static").is(':checked')
        $(".source").addClass("hide")
        $(".seo").addClass("hide")
        $(".category").addClass("hide")
      else
        $(".source").removeClass("hide")
        $(".seo").removeClass("hide")
        $(".category").removeClass("hide")

    toggle_static()
    $("#post_is_static").on "change", toggle_static


$(document).ready(ready)
$(document).on('page:load', ready)