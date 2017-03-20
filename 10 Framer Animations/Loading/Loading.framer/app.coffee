# Import file "Loading" (sizes and positions are scaled 1:2)
sketch = Framer.Importer.load("imported/Loading@2x")
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
sketch.Group_2.visible = false

#Variables
width = 600
height = 234

track = new Layer
	width: 600
	height: 234
	x: Screen.midX - width/2
	y: Screen.midY - 117
	image: "images/track.png"

dot = new Layer
	parent: track
	width: 40
	height: 40
	x: Align.center
	y: Align.center
	borderRadius: "50%"
	backgroundColor: Color.main
	shadowColor: Color.main
	shadowBlur: 20

dot1 = new Layer
	parent: track
	width: 40
	height: 40
	x: Align.center
	y: Align.center
	borderRadius: "50%"
	backgroundColor: "#ffd180"
	shadowColor: "#ffd180"	
	shadowBlur: 20
	
#Animaiton
angle = 0

Utils.interval 0.015, ->
	dot.midX = width/2 + 90*Math.sin(angle/180*3)
	dot.midY = height/2 + 90*Math.sin(angle*2/180*3)
# 	print dot.x
# 	print dot.y
	
	dot1.midX = width/2 - 90*Math.sin(angle/180*3)
	dot1.midY = height/2 - 90*Math.sin(angle*2/180*3)
	
	angle += 3

#Dot coloar change
# dot.on "change:x", ->
# 	r = Utils.modulate(dot.x, [190, 369], [33, 255], true)
# 	g = Utils.modulate(dot.x, [190, 369], [150, 209], true)
# 	b = Utils.modulate(dot.x, [190, 369], [243, 128], true)
	# When ›dot‹ is between x position 199 and 369,
	# calculate color from rgb(0, 25, 138) to rgb(229, 227, 31)
# 	dot.backgroundColor = "rgb(#{r}, #{g}, #{b})"
# 	dot.shadowColor = "rgb(#{r}, #{g}, #{b})"	
# 
# dot1.on "change:x", ->
# 	r = Utils.modulate(dot.x, [190, 369], [255, 33], true)
# 	g = Utils.modulate(dot.x, [190, 369], [209, 150], true)
# 	b = Utils.modulate(dot.x, [190, 369], [128, 243], true)
# 	dot1.backgroundColor = "rgb(#{r}, #{g}, #{b})"
# 	dot1.shadowColor = "rgb(#{r}, #{g}, #{b})"	


dot.on "change:x", ->
	if dot.x > 280
		r = 33
		g = 150
		b = 243
		dot.backgroundColor = "rgb(#{r}, #{g}, #{b})"
		dot.shadowColor = "rgb(#{r}, #{g}, #{b})"	
	else
		r = 255
		g = 209
		b = 128
		dot.backgroundColor = "rgb(#{r}, #{g}, #{b})"
		dot.shadowColor = "rgb(#{r}, #{g}, #{b})"	

dot1.on "change:x", ->
	if dot1.x < 280
		r = 255
		g = 209
		b = 128
		dot1.backgroundColor = "rgb(#{r}, #{g}, #{b})"
		dot1.shadowColor = "rgb(#{r}, #{g}, #{b})"	
	else
		r = 33
		g = 150
		b = 243
		dot1.backgroundColor = "rgb(#{r}, #{g}, #{b})"
		dot1.shadowColor = "rgb(#{r}, #{g}, #{b})"	

		
