# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  @mlmap = null

  $('.toggle-icon').on 'change', (ev) =>
    target = ev.target
    visible = target.checked
    userid = $(target).attr('data-target-id')
    @mlmap.draw()

  $('td textarea').on 'keyup', (ev) =>
    @mlmap.draw()

  $('#mlmap-output-button').on 'click', (ev) =>
    window.open @mlmap.toDataURL()

  $(document).on 'ready', (ev) =>
    setTimeout () =>
      init($('canvas#mlmap')[0])
    , 100

  init = (canvas) =>
    @mlmap = new Mlmap(canvas)
    $.each $('.mlmap-row'), (i, item) =>
      [id, spnum, spalp] = [$(item).attr('data-target-id'), $(item).attr('data-spnum'), $(item).attr('data-spalp')]
      @mlmap.addUser({
        id: id
        spnum: spnum
        spalp: spalp
        textfield: $("#memo-#{id}")[0]
        icon: $('.mlmap-user-icon', item)[0]
        checkbox: $('.toggle-icon', item)[0]
      })
    @mlmap.draw()
