# Import file "Hover" (sizes and positions are scaled 1:2)
sketch = Framer.Importer.load("imported/Hover@2x")

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
card_1 = sketch.card_1
heart = sketch.heart
heartCover = sketch.heartCover
heartFull = sketch.heartFull
heartHollow = sketch.heartHollow
heartFill = sketch.heartFill

heartCover.states.add
	hover:
		scale: 10
	animationOptions:
		time: 0.5
		curve: Bezier.easeIn

eight = new Layer
	html: 8
	x: 153
	y: 909
	color: Color.main
	backgroundColor: null
	style: 
		fontFamily: "Roboto"
		fontSize: "28px"
		fontWeight: 500
		
nine = new Layer
	html: 9
	x: 153
	y: 879
	opacity: 0
	color: Color.main
	backgroundColor: null
	style: 
		fontFamily: "Roboto"
		fontSize: "28px"
		fontWeight: 500

nine.states.add
	down:
		opacity: 1
		y: 909

eight.states.add
	down:
		y: 939
		opacity: 0

heartFull.states.add
	zoomIn:
		scale: 1.1
		animationOptions:
			time: 0.2
			curve: Bezier.easeOut
	zoomOut:
		scale: 0
		opacity: 0
		animationOptions:
			time: 0.4
			curve: Bezier.easeIn

heartFill.states.add
	zoomIn:
		scale: 1.2
		opacity: 0.8
		animationOptions:
			time: 0.2
			curve: Bezier.easeOut
	zoomOut:
		scale: 1
		animationOptions:
			time: 0.2
			curve: Bezier.easeOut
		
card_1.onLongPress ->
	heart.visible = true
	heartCover.visible = true
	heartCover.states.switch "hover"
	heartCover.onAnimationEnd ->
		heart.visible = false
		heartCover.visible = false
		heartFull.visible = true 
		heartFull.states.switch "zoomIn"
		Utils.delay 0.2, ->
			heartFull.states.switch "zoomOut"
		Utils.delay 0.2, ->
			heartHollow.visible = false
			heartFill.visible = true
			heartFill.states.switch "zoomIn"
			Utils.delay 0.2, ->
				heartFill.states.switch "zoomOut"
				eight.states.switch "down"
				nine.states.switch "down"







		
