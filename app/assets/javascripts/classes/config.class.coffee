class window.MlCnf
  @TITLE: 'Mlmap Generator'
  @FONT:
    STYLE: 'normal'
    SIZE: 18
    FAMILY: 'sans-serif'
    COLOR: '#666666'
  @MAP:
    WIDTH: 800
    HEIGHT: 708
    BGCOLOR: 'white'
    OBJCOLOR: '#eeeeee'

    SPSTAGE:
      COLOR: '#cccccc'
      POS:
        X: 300
        Y: 0
      SIZE:
        WIDTH: 300
        HEIGHT: 80
    MAILRECEPTION:
      COLOR: '#cccccc'
      POS:
        X: 0
        Y: 220
      SIZE:
        WIDTH: 120
        HEIGHT: 100
    BORDER:
      COLOR: '#aaaaaa'
      WIDTH: 0.5

    BLOCKS: [
      # P1〜6
      {
        POS:
          X: 40
          Y: 80
        SIZE:
          WIDTH: 30
          HEIGHT: 120
        SPACES: [1..2]
        ORDER_ASC: true
        TEXT_POSITION: 'right'
      }
      {
        POS:
          X: 40
          Y: 360
        SIZE:
          WIDTH: 30
          HEIGHT: 240
        SPACES: [3..6]
        ORDER_ASC: true
        TEXT_POSITION: 'right'
      }

      # P7〜24
      {
        POS:
          X: 220
          Y: 140
        SIZE:
          WIDTH: 30
          HEIGHT: 540
        SPACES: [7..15]
        ORDER_ASC: false
        TEXT_POSITION: 'left'
      }
      {
        POS:
          X: 270
          Y: 140
        SIZE:
          WIDTH: 30
          HEIGHT: 540
        SPACES: [16..24]
        ORDER_ASC: true
        TEXT_POSITION: 'right'
      }

      # P25〜40
      {
        POS:
          X: 420
          Y: 200
        SIZE:
          WIDTH: 30
          HEIGHT: 480
        SPACES: [25..32]
        ORDER_ASC: false
        TEXT_POSITION: 'left'
      }
      {
        POS:
          X: 470
          Y: 200
        SIZE:
          WIDTH: 30
          HEIGHT: 480
        SPACES: [33..40]
        ORDER_ASC: true
        TEXT_POSITION: 'right'
      }

      # P41〜58
      {
        POS:
          X: 620
          Y: 140
        SIZE:
          WIDTH: 30
          HEIGHT: 540
        SPACES: [41..49]
        ORDER_ASC: false
        TEXT_POSITION: 'left'
      }
      {
        POS:
          X: 670
          Y: 140
        SIZE:
          WIDTH: 30
          HEIGHT: 540
        SPACES: [50..58]
        ORDER_ASC: true
        TEXT_POSITION: 'right'
      }
    ]
    ICON:
      WIDTH: 30
      HEIGHT: 30
