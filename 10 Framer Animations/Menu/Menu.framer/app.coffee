# Import file "Menu" (sizes and positions are scaled 1:2)
sketch = Framer.Importer.load("imported/Menu@2x")
# General settings
Utils.insertCSS("@import 'https://fonts.googleapis.com/css?family=Roboto:300,400,700';")
Canvas.backgroundColor = "#303030"
Screen.backgroundColor = "#303030"
Color.main = "#2196f3"
Boxshadow = "0 4px 4px 0 rgba(0, 0, 0, 0.24), 0 0 4px 0 rgba(0, 0, 0, 0.12)"
w = 344 * 2
h = 224 * 2
Framer.Defaults.Animation = 
    curve: "cubic-bezier(0.4, 0.0, 0.2, 1)"
    time: .4


sketch.menu.visible = false
# sketch.BG.visible = false
# sketch.wordtext.visible = false
# sketch.Transition_Copy.backgroundColor = null
# form = sketch.form
# add = sketch.add
# list = sketch.list
# line = sketch.line
menuBars = []
menuContents = []

menuWrap = new Layer
	backgroundColor: null
	y: 40
	height: 136
	width: 136
	open: false

[0..2].forEach (i) ->
	menuBar = new Layer
		parent: menuWrap
		width: 18 * 2 
		height: 4
		x: Align.center
		y: i * 10 + 46
		backgroundColor: "#fff"
	menuBars.push(menuBar)
		
contentWrap = new Layer
	width: 296 * 2
	height: 56 * 3 *2
	x: Align.center
	y: Align.center
	borderRadius: 4
	backgroundColor: null
	
[0..2].forEach (i) ->
	menuContent = new Layer
		parent: contentWrap
		backgroundColor: "#fafafa"
		width: 296 * 2
		height: 56 * 2
		y: 56 * 2 * i
		style: 
			color: "rgba(0, 0, 0, 0.54)"
			fontSize: "28px"
			textAlign: "center"
			lineHeight: "112px"
			boxShadow: "0 8px 8px 0 rgba(0, 0, 0, 0.24), 0 0 8px 0 rgba(0, 0, 0, 0.12)"
					
	menuContents.push(menuContent)

menuContents[0].html = "Menu One"
menuContents[1].html = "Menu Two"
menuContents[2].html = "Menu Three"

layers = [menuContents[0], menuContents[1], menuContents[2], menuBars[0], menuBars[1], menuBars[2], contentWrap]

menuContents[0].states.add
	default:
		y: 0
		style:
			borderRadius: "4px 4px 0 0"
	expand:
		y: -32
		style:
			borderRadius: "4px"
		animationOptions:
			time: 0.3
			delay: 0.2

menuContents[1].states.add
	default:
		y: 112
		style:
			borderRadius: "0"
	expand:
		y: 112
		style:
			borderRadius: "4px"
		animationOptions:
			time: 0.3
			delay: 0.2

menuContents[2].states.add
	default:
		y: 224
		style:
			borderRadius: "0 0 4px 4px"
	expand:
		y: 256
		style:
			borderRadius: "4px"
		animationOptions:
			time: 0.3
			delay: 0.2

menuBars[0].states.add
	expand:
		rotation: 135
		y: 56
		animationOptions:
			curve: Spring(damping: 0.6)
			time: 0.4

menuBars[1].states.add
	expand:
		rotation: 90
		scale: 0
		animationOptions:
			curve: Spring(damping: 0.6)
			time: 0.4

menuBars[2].states.add
	expand:
		rotation: 45
		y: 56
		animationOptions:
			curve: Spring(damping: 0.6)
			time: 0.4

contentWrap.states.add
	default:
		opacity: 0
		scale: 0
		animationOptions:
			curve: Bezier.easeIn
			time: 0.2
	expand:
		opacity: 1
		scale: 1
		animationOptions:
			curve: Bezier.easeOut
			time: 0.2
		
# fab.states.animationOptions =
# 	delay: .5
# form.states.animationOptions = 
# 	delay: .5
# line.states.animationOptions = 
# 	delay: .5
	
for layer in layers
	layer.stateSwitch("default")
	
menuWrap.on "click", ->
	menuWrap.open = !menuWrap.open				
	if menuWrap.open is false
		for layer in layers
			layer.states.switch "expand"
	else
		for layer in layers
			layer.states.switch "default"


