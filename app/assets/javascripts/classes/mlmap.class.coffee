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
    this._drawSpaces()

    $.each @users, (i, user) =>
      return unless user.checkbox.checked

      [x, y, block] = this.getSpacePosition(user.spnum, user.spalp)
      @ctx.drawImage(
        user.icon,
        x,
        y,
        MlCnf.MAP.ICON.WIDTH,
        MlCnf.MAP.ICON.HEIGHT
      )
      if block.TEXT_POSITION == 'right'
        this._drawString(user.textfield.value, x + 35, y, { font: { style: 'bold', size: 6, color: 'red' } })
      else
        this._drawString(user.textfield.value, x - 5, y, { font: { style: 'bold', size: 6, color: 'red' }, text_align: 'end' })

    this._drawString('ミリフェスマップ', 30, 30, { font: { size: 23, color: '#333333', style: 'bold' }})
    this

  getSpacePosition: (space_num, space_alphabet) ->
    sp_block = this.getBlockBySpaceNum(space_num)
    rel_spnum = space_num - sp_block.SPACES[0]

    pos_y = 0
    if sp_block.ORDER_ASC
      pos_y = sp_block.POS.Y + rel_spnum * MlCnf.MAP.ICON.HEIGHT * 2
    else
      pos_y = sp_block.POS.Y + sp_block.SIZE.HEIGHT - (rel_spnum + 1) * MlCnf.MAP.ICON.HEIGHT * 2

    if space_alphabet?
      pos_y += MlCnf.MAP.ICON.HEIGHT if space_alphabet == (if sp_block.ORDER_ASC then 'b' else 'a')
      pos_y += MlCnf.MAP.ICON.HEIGHT / 2 if space_alphabet == 'ab'

    [sp_block.POS.X, pos_y, sp_block]

  getBlockBySpaceNum: (space_num) ->
    space_num = parseInt space_num
    for block in MlCnf.MAP.BLOCKS
      if space_num in block.SPACES
        return block

  _resetCanvas: () ->
    @ctx.save()
    @ctx.clearRect(0, 0, @canvas.width, @canvas.height)
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

  _drawSpaces: () ->
    border = MlCnf.MAP.BORDER
    @ctx.save()
    for i in [1..58]
      [x, y, block] = this.getSpacePosition(i)
      @ctx.strokeStyle = border.COLOR
      @ctx.lineWidth = border.width
      @ctx.strokeRect(x - 1, y, block.SIZE.WIDTH + 2, block.SIZE.WIDTH * 2)
      str_num = if i < 10 then "0#{i}" else "#{i}"
      this._drawString("#{str_num}", x + 15, y + 25, { font: { size: 14, color: '#cccccc' }, text_align: 'center' })
    @ctx.restore()

  _drawString: (str, x, y, conf) ->
    @ctx.save()

    f = conf?.font
    @ctx.font = "#{f?.style || 'normal'} #{f?.size || MlCnf.FONT.SIZE}px #{f?.family || MlCnf.FONT.FAMILY}"
    @ctx.fillStyle = f?.color || MlCnf.FONT.COLOR
    @ctx.textAlign = conf?.text_align || 'start'
    @ctx.textBaseline = conf?.text_baseline || 'top'

    line_height = @ctx.measureText('　').width
    arr = str.split('\n')
    for line, index in arr
      @ctx.fillText(line, x, y + line_height * index)
    @ctx.restore()
