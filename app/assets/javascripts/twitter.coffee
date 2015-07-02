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

  $(document).on 'ready', (ev) =>
    c = $('canvas#mlmap')[0]
    @mlmap = new Mlmap(c)
    $.each $('.mlmap-row'), (i, item) =>
      [id, spnum, spalp] = [$(item).attr('data-target-id'), $(item).attr('data-spnum'), $(item).attr('data-spalp')]
      @mlmap.addUser({
        id: id
        spnum: spnum
        spalp: spalp
        icon: $('.mlmap-user-icon', item)[0]
      })
    @mlmap.draw()
