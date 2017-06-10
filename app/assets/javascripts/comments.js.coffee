ready = ->
$(document).on 'click', 'a.edit', ->
    id= $(this).attr('id')
    $.get("/comments/#{id}/edit")

$(document).on 'click', 'a.close', ->
    id= $(this).attr('id')
    $.get("/comments/#{id}")

$(document).ready(ready)
$(document).on('page:load', ready)
