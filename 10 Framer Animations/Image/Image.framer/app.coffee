# Import file "Image" (sizes and positions are scaled 1:2)
sketch = Framer.Importer.load("imported/Image@2x")
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

night = sketch.night
day = sketch.day
nightCloud = sketch.nightCloud
dayCloud = sketch.dayCloud
layers = [night, day]

night.states.add
	default:
		x: 0
	right:
		x: 375 * 2
		animationOptions:
			time: 2.2
			curve: Bezier.easeOut

day.states.add
	default:
		x: 0
	right:
		x: 375 * 2
		animationOptions:
			time: 2.2
			curve: Bezier.easeOut

shaking = (layer) ->
	animationA = new Animation layer,
		x: 180
		options:
			time: 0.4
			curve: Spring(damping: 0.6)
		
	animationB = animationA.reverse()
	animationA.start()

for layer in layers
	layer.stateSwitch("default")

day.on "change:x", ->
	if day.x > 180
		shaking(nightCloud)
	if day.x >= 375 * 2
		day.placeBehind night
		day.stateSwitch("default")	
		night.states.switch "right"
		dayCloud.x = 132
		
night.on "change:x", ->
	if night.x > 180
		shaking(dayCloud)
	if night.x >= 375 * 2
		night.placeBehind day
		night.stateSwitch("default")	
		day.states.switch "right"
		nightCloud.x = 132

day.states.switch "right"		
		