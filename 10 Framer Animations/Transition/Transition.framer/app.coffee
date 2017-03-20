# Import file "Transition" (sizes and positions are scaled 1:2)
sketch = Framer.Importer.load("imported/Transition@2x")
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

sketch.fab.visible = false
sketch.BG.visible = false
sketch.wordtext.visible = false
sketch.Transition_Copy.backgroundColor = null
form = sketch.form
add = sketch.add
list = sketch.list
line = sketch.line

fab = new Layer
	width: 56 * 2
	height: 56 * 2
	borderRadius: "50%"
	backgroundColor: Color.main
	x: 303 * 2
	y: 579 * 2
	clip: true        
	style:
		boxShadow: "0 12px 12px 0 rgba(0, 0, 0, 0.24), 0 0 12px 0 rgba(0, 0, 0, 0.12)"
		
sketch.add.parent = fab
sketch.add.center()
sketch.Transition_Copy.x = 0

fab.placeBehind sketch.Transition_Copy

backButton = new Layer
	parent: sketch.form
	width: 80
	height: 80
	borderRadius: "50%"
	x: 30
	y: 30
	backgroundColor: null
	clip: true
	
form.states.add
	default:
		y: Screen.height
	upload:
		y: form.y

add.states.add
	upload:
		opacity: 0
		rotation: 90		

fab.states.add
	upload:
		x: - Screen.width / 2
		y: - Screen.width * 1.3
		width: Screen.width * 2
		height: Screen.width * 2

line.states.add
	default:
		opacity: 1
	upload:
		opacity: 0

fab.states.animationOptions =
	delay: .2
form.states.animationOptions = 
	delay: .2
line.states.animationOptions = 
	delay: .4
	repeat: 100

layers = [form, add, fab, line]
for layer in layers
	layer.stateSwitch("default")

rippleEffect = (event, layer) ->
	ripple = new Layer
		parent: layer
		borderRadius: "50%"
		scale: 0
		opacity: .5
		width: layer.width
		height: layer.height
		backgroundColor: "#fff"
	ripple.animate
		scale: 2
		opacity: 0
		options: 
			curve: Bezier.easeOut
	ripple.on "end", ->
		ripple.destroy()	
	
fab.on "click", ->
	rippleEffect(event, this)
	for layer in layers
		layer.states.switch "upload"

backButton.on "click", ->
	rippleEffect(event, this)
	Utils.delay .2, ->
		fab.stateSwitch("default") 
		add.stateSwitch("default") 
		for layer in layers
			if layer isnt fab && layer isnt add
				layer.states.switch "default",
					curve: "cubic-bezier(0.4, 0, 1, 1)" 
					time: .2
