class window.Mlmap
  constructor: (canvas) ->
    @canvas = canvas
    @ctx = @canvas.getContext('2d')
    @users = []

  addUser: (user) ->
    @users.push user
    this

  draw: () ->
    this._resetCanvas()

    this._drawStage()
    this._drawBlocks()

    $.each @users, (i, user) =>
      [x, y] = this.getSpacePosition(user.spnum, user.spalp)
      @ctx.drawImage(
        user.icon,
        x,
        y,
        MlCnf.MAP.ICON.WIDTH,
        MlCnf.MAP.ICON.HEIGHT
      ) if $("#visible-icon-#{user.id}")[0].checked

    this._drawString('ミリフェスマップ', 30, 30, { font: { size: 23, color: '#333333', style: 'bold' }})
    this

  getSpacePosition: (space_num, space_alphabet) ->
    sp_block = this.getBlockBySpaceNum(space_num)
    rel_spnum = space_num - sp_block.SPACES[0]

    pos_y = 0
    if sp_block.ORDER_ASC
      pos_y = sp_block.POS.Y + rel_spnum * MlCnf.MAP.ICON.HEIGHT * 2
      pos_y += MlCnf.MAP.ICON.HEIGHT if space_alphabet == 'b'
    else
      pos_y = sp_block.POS.Y + sp_block.SIZE.HEIGHT - (rel_spnum + 1) * MlCnf.MAP.ICON.HEIGHT * 2
      pos_y += MlCnf.MAP.ICON.HEIGHT if space_alphabet == 'a'
    pos_y += MlCnf.MAP.ICON.HEIGHT / 2 if space_alphabet == 'ab'

    [sp_block.POS.X, pos_y]

  getBlockBySpaceNum: (space_num) ->
    space_num = parseInt space_num
    for block in MlCnf.MAP.BLOCKS
      if space_num in block.SPACES
        return block

  _resetCanvas: () ->
    @ctx.save()
    @ctx.fillStyle = MlCnf.MAP.BGCOLOR
    @ctx.fillRect(0, 0, MlCnf.MAP.WIDTH, MlCnf.MAP.HEIGHT)
    @ctx.restore()

  _drawStage: () ->
    @ctx.save()

    c = MlCnf.MAP.SPSTAGE
    @ctx.fillStyle = c.COLOR
    @ctx.fillRect(c.POS.X, c.POS.Y, c.SIZE.WIDTH, c.SIZE.HEIGHT)
    this._drawString('特設ステージ', c.POS.X + 95, 30)

    c = MlCnf.MAP.MAILRECEPTION
    @ctx.fillStyle = c.COLOR
    @ctx.fillRect(c.POS.X, c.POS.Y, c.SIZE.WIDTH, c.SIZE.HEIGHT)
    this._drawString('宅配便受付', 15, c.POS.Y + 40)

    this._drawString('入口', MlCnf.MAP.WIDTH - 50, MlCnf.MAP.HEIGHT - 30)
    @ctx.restore()

  _drawBlocks: () ->
    @ctx.save()
    @ctx.fillStyle = MlCnf.MAP.OBJCOLOR

    c = MlCnf.MAP.BLOCKS
    for i in [0...(c.length)]
      @ctx.fillRect(c[i].POS.X, c[i].POS.Y, c[i].SIZE.WIDTH, c[i].SIZE.HEIGHT)

    @ctx.restore()

  _drawString: (str, x, y, conf) ->
    @ctx.save()

    f = conf?.font
    @ctx.font = "#{f?.style || 'normal'} #{f?.size || MlCnf.FONT.SIZE}px #{f?.family || MlCnf.FONT.FAMILY}"
    @ctx.fillStyle = f?.color || MlCnf.FONT.COLOR
    @ctx.textAlign = conf?.text_align || 'start'
    @ctx.textBaseline = conf?.text_baseline || 'top'
    @ctx.fillText(str, x, y)
    @ctx.restore()
