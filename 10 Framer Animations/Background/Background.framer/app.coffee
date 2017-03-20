# Import file "Background" (sizes and positions are scaled 1:2)
sketch = Framer.Importer.load("imported/Background@2x")
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

close = sketch.close
away = sketch.away
farAway = sketch.far_away
layers = [close, away, farAway]

close.states.add
	up:
		y: -close.height
		options: 
			time: 3
			curve: Bezier.easeIn
	down:
		y: Screen.height


away.states.add
	up:
		y: -away.height
		options: 
			time: 3 * 1.4
			curve: Bezier.easeIn
	down:
		y: Screen.height
	
farAway.states.add
	up:
		y: -farAway.height
		options: 
			time: 3 * 1.8
			curve: Bezier.easeIn
	down:
		y: Screen.height

for layer in layers
	layer.stateSwitch("down")

for layer in layers
	layer.states.switch "up"

farAway.onAnimationEnd ->
	for layer in layers
		layer.stateSwitch("down")
	for layer in layers
		layer.states.switch "up"
	