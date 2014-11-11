ready = ->
  if $("#image_id")[0]
    uploader = $("#image_id").closest("a")
    upload_type = uploader.data("upload-type") || "default"
    new Upload({upload_url: uploader.data("upload-url"), target: uploader.data("target"), upload_type: upload_type})

$(document).ready(ready)
$(document).on('page:load', ready)

window.Upload = class Upload
  ## @params
  ## upload_url
  ## target
  constructor: (@params) ->
    # vars
    @upload_url  = @params.upload_url
    @target      = @params.target
    @upload_type = @params.upload_type

    # elements
    @thumbnail_elem = $(".upload-display")

    @target_elem    = $(@target)
    @download_elem  = $(".download-file")
    @delete_elem    = $(".delete-image")

    # events
    @delete_elem.on "click", (e) => @deleteUpload(e)

    # init
    @fileUploadInit()

  fileUploadInit: () =>
    $("#image_id").fileupload
      url: @upload_url
      dataType: "json"
      done: (e, data) =>
        if data.result.errors
          @renderErrors data.result.errors
        else
          @renderUpload data.result
        return

  renderErrrors: (errors) ->
    alert(errors)

  renderUpload: (upload) ->
    @setTargetValue(upload)
    @thumbnail_elem.attr("src", upload.file_thumbnail_url).removeClass("hide")

  setTargetValue: (upload) ->
    if @upload_type == "setting"
      @target_elem.val("Upload,#{upload.id}")
    else
      @target_elem.val(upload.id)

  deleteUpload: (e) =>
    @target_elem.val("")
    @thumbnail_elem.addClass("hide")
    @download_elem.addClass("hide")
    @delete_elem.addClass("hide")
