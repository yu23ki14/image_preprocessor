$ ->
  images_path = gon.files
  root_path_name = gon.root_path_name
  current_step = 0
  length = images_path.length
  cropper = null
  
  arr_diff = (img) ->
    croppable = false
    cropper = new Cropper(img,
      aspectRatio: 1
      viewMode: 1
      autoCrop: false
      ready: ->
        croppable = true
        return
      )
  
  next_image = () ->
    current_step += 1
    new_image = images_path[current_step]
    cropper.replace(new_image)
    $(".current-step").text(current_step + 1)
  
  prev_image = () ->
    if current_step > 0
      current_step -= 1
      new_image = images_path[current_step]
      cropper.replace(new_image)
      $(".current-step").text(current_step + 1)
      
  push_data = (root_path_name, x, y, w, h) ->
    $.ajax(
        type: 'POST',
        url: "/projects/preprocess",
        data: {
                'path_name': root_path_name,
                'order_num': current_step,
                'x': x,
                'y': y,
                'w': w,
                'h': h
              }
      ).done (data) ->
        $(".result-toaster").text(data.result)
        $(".result-toaster").fadeIn(300).delay(500).fadeOut(300)
  
  image = document.getElementById('trimed_image')
  arr_diff(image)

  $(".js-save-next").click ->
    data = cropper.getData(true)
    root_path_name = root_path_name
    x = data.x
    y = data.y
    w = data.width
    h = data.height
    push_data(root_path_name, x, y, w, h)
    next_image()
    return
  
  $(".js-save").click ->
    data = cropper.getData(true)
    root_path_name = root_path_name
    x = data.x
    y = data.y
    w = data.width
    h = data.height
    push_data(root_path_name, x, y, w, h)
    
    return
  
  $(".js-next").click ->
    next_image()
    
    return
  
  $(".js-prev").click ->
    prev_image()
    
    return
  
  $(document).keydown (e) ->
    code = e.keyCode
    if code == 65 #a
      $(".js-prev").click()
    else if code == 83 #s
      $(".js-next").click()
    else if code == 68 #d
      $(".js-save").click()
    else if code == 70 #f
      $(".js-save-next").click()