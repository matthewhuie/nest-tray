{ app, BrowserWindow, screen, Tray } = require 'electron'

app.dock.hide()

app.on 'ready', ->
  t = new Tray 'lib/icon.png'
  t.on 'click', (event) ->
    toggleWindow()

  bw = new BrowserWindow
    width: 400,
    height: 720,
    show: false,
    frame: false,
    fullscreenable: false,
    resizeable: false,
    transparent: true
  bw.loadURL 'https://home.nest.com'
  bw.on 'blur', ->
    bw.hide()  

  toggleWindow = ->
    if bw.isVisible()
      bw.hide()
    else
      sb = screen.getPrimaryDisplay().workAreaSize
      tb = t.getBounds()
      bwb = bw.getBounds()
      x = Math.min tb.x, sb.width - tb.width
      y = tb.y + tb.height
      bw.setPosition x, y
      bw.show()
