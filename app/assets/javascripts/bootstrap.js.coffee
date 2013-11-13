ready = ->
  $("a[rel~=popover], .has-popover").popover()
  $("a[rel~=tooltip], .has-tooltip").tooltip()
  $('.dropdown-toggle').dropdown()
  $('input.datepicker').datepicker({
    language: 'pt-BR',
    format: 'dd/mm/yyyy'
  })

$(document).ready(ready)