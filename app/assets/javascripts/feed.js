$('.likes').on('ajax:success', function() {
  var count;
  var count, name;
  name = $(this).attr('name');
  if ($('a[name="'+name+'"]').attr('flag') === '1') {
    $(this).attr('flag', '0');
    $(this).html('<i class="fas fa-heart like"></i>');
    count = parseInt($('p[name="'+name+'"]').text());
    count++;
    $('p[name="'+name+'"]').text(count);
  } else {
    $(this).attr('flag', '1');
    $(this).html('<i class="far fa-heart like"></i>');
    count = parseInt($('p[name="'+name+'"]').text());
    count--;
    $('p[name="'+name+'"]').text(count);
  }
});