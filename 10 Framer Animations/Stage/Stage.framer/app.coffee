InputModule = require "input"

# General settings
Utils.insertCSS("@import 'https://fonts.googleapis.com/css?family=Roboto:300,400,700';")
Canvas.backgroundColor = "#303030"
Screen.backgroundColor = "#303030"
Color.main = "#2196f3"
Boxshadow = "0 4px 4px 0 rgba(0, 0, 0, 0.24), 0 0 4px 0 rgba(0, 0, 0, 0.12)"
w = 344 * 2
h = 224 * 2

# Variables
tileCount = 9
columnCount = 3
gutter = 8
tiles = []

layerGroup = new Layer
	width: 356 * 2
	height: 356 * 2
	backgroundColor: null
	x: Align.center
	y: Align.center

tileWidth = 115 * 2
tileOffset = tileWidth + gutter

# Loop to create grid tiles
tilesGroup = new Layer
	parent: layerGroup
	width: 356 * 2
	height: 356 * 2
	backgroundColor: null
	x: Align.center
	clip: true
	
for index in [0...tileCount]
	
	columnIndex = index % columnCount
	rowIndex = Math.floor(index / columnCount)
	
	tile = new Layer
		parent: tilesGroup
		x: columnIndex * tileOffset
		y: rowIndex * tileOffset
		size: tileWidth
		borderRadius: 4
		backgroundColor: "#fff"
		style: 
			boxShadow: Boxshadow			
	tiles.push(tile)
	
[5..8].forEach (i) ->
	tiles[i].backgroundColor = "#757575"	
	
tiles[4].backgroundColor = "#90caf9"
tiles[4].index = 999
	
tiles[4].shadowColor = Color.main
tiles[4].shadowBlur = 20
	
animation12 = new Animation tiles[4],
	shadowBlur: 40
	backgroundColor: "#d2eafc"
	options:
		curve: Bezier.easeInOut		
		time: 0.8

animation13 = new Animation tiles[4],
	shadowBlur: 120
	backgroundColor: "#e8f4fd"
	options:
		curve: Bezier.easeInOut
		time: 0.8

Shining = () ->
	animation12.start()
	animation21 = animation12.reverse()
	animation12.on Events.AnimationEnd, 
		animation21.start
	animation21.on Events.AnimationEnd, 
		animation13.start
	animation31 = animation13.reverse()
	animation13.on Events.AnimationEnd, 
		animation31.start

Shining()
shiningInterval = Utils.interval 3.2, ->
	Shining()

AnimationZoomIn = new Animation tilesGroup,
	scale: 1.05
	options:
		time: 0.1
		curve: Bezier.ease
	
AnimationZoomOut = new Animation tilesGroup,
	scale: 0.01
	options:
		time: 0.2
		curve: Bezier.easeIn
	
AnimationMoveUp = new Animation tilesGroup,
	y: -354
	borderRadius: 356 * 2
	options:
		time: 0.2
		curve: Bezier.easeInOut
	
radius = 330
stroke = 4
viewBox = (radius * 2) + stroke

circle = new Layer
	parent: layerGroup
	x: Align.center
	width: viewBox
	height: viewBox
	backgroundColor: null
	rotation: -90  

circle.pathLength = 2 * Math.PI * radius
circle.html = """
  <svg viewBox='-#{stroke/2} -#{stroke/2} #{viewBox} #{viewBox}'>
    <circle fill='none' stroke='#fff'
      stroke-width      = '#{stroke}'
      stroke-dasharray  = '#{circle.pathLength}'
      stroke-dashoffset = '#{circle.pathLength}'
      cx = '#{radius}'
      cy = '#{radius}'
      r  = '#{radius}'>
  </svg>"""

Utils.domComplete ->
	circle.path = document.querySelector('svg circle')
  
proxy = new Layer
	x: 1	
	
proxy.on 'change:x', ->
	offset = Utils.modulate(@.x, [0, 200], [circle.pathLength, 0])
	circle.path.setAttribute 'stroke-dashoffset', offset
proxy.visible = false

AnimationCircle = new Animation proxy,
	x: 200
	options:
		time: 1.5
		curve: Bezier.easeInOut

circle.visible = false

dialog = new Layer
	parent: layerGroup
	x: Align.center
	y: Align.center
	width: 656
	height: 462
	image: "images/dialog.png"
	scale: 0
	opacity: 0

AnimationPopUp = new Animation dialog,
	scale: 1
	opacity: 1
	options:
		time: 0.2
		curve: Bezier.easeOut			  

tiles[4].onClick ->
	clearInterval(shiningInterval)
	AnimationZoomIn.start()
	AnimationZoomIn.on Events.AnimationEnd, AnimationZoomOut.start
	AnimationZoomOut.on Events.AnimationEnd, AnimationMoveUp.start
	AnimationMoveUp.on Events.AnimationEnd, ->
		tilesGroup.visible = false	
		circle.visible = true
		AnimationCircle.start()
	AnimationCircle.on Events.AnimationEnd, ->
		circle.visible = false
		AnimationPopUp.start()

hint = new Layer
	width: 312 * 2
	x: Align.center
	y: Screen.height - 182
	backgroundColor: null
	html: "THIS STAGE ANIMATION PURPOSES ARE ATTENTION, FEEDBACK, RELIEF AND INDIVIDUALIZATION"
	style:
		fontFamily: "Roboto"
		fontSize: "32px"
		lineHeight: "48px"
		letterSpacing: "0.5px"
		textAlign: "center"
		color: "rgba(255, 255, 255, 0.87)"

Status_bar = new Layer
	width: 750
	height: 40
	image: "images/Status_bar.png"
