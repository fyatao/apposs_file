jQuery ->
  $("a[rel=popover]").popover()
  $(".tooltip").tooltip()
  $("a[rel=tooltip]").tooltip()

window.msg = (msg) ->
    $('#main_c').before('<div class="alert"><button class="close" data-dismiss="alert">x</button><pre>' + msg + '</pre></div>')

  
