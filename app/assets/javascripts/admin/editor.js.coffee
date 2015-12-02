ready = ->
  if $("#editor")[0]

    new Vue(
      el: "#editor"
      data:
        input: ""
      filters:
        marked: marked
    )

    # attempt to keep the scrolling in sync
    editor  = $("#editor textarea")
    preview = $("#editor .markdown-preview")
    editor.on "scroll", ->
      preview.scrollTop editor.scrollTop()

$(document).ready(ready)
$(document).on('page:load', ready)