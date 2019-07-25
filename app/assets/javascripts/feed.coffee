$(document).on 'ajax:success', '.like_photo', (event) ->
    detail = event.detail
    data = detail[0]
    console.log(data)
    span_count_like = $(this).find('.count-like-photo')
    like = $(this).find('.span-like-photo')
    like.toggleClass('liked-photo')
    text_count_like = parseInt(span_count_like.text())
    if data['type'] == 'like'
      text_count_like += 1
      span_count_like.text text_count_like
    else if data['type'] == 'unlike'
      text_count_like -= 1
      span_count_like.text text_count_like

$(document).on 'ajax:success', '.like_album', (event) ->
    detail = event.detail
    data = detail[0]
    console.log(data)
    span_count_like = $(this).find('.count-like-album')
    like = $(this).find('.span-like-album')
    like.toggleClass('liked-album')
    text_count_like = parseInt(span_count_like.text())
    if data['type'] == 'like'
      text_count_like += 1
      span_count_like.text text_count_like
    else if data['type'] == 'unlike'
      text_count_like -= 1
      span_count_like.text text_count_like