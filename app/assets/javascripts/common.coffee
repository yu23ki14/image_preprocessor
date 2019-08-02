$ ->
    $(".alert").delay(1300).fadeOut("normal")
  
    $(document).on 'click', '.close-modal', (e) ->
      $('.modal').modal('hide')
      
    $(document).on 'click', '.open-modal', (e) ->
      target = $(this).attr('target_modal')
      $('.modal.' + target).modal()