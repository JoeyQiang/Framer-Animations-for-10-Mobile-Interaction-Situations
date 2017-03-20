
#General
Utils.insertCSS("@import 'https://fonts.googleapis.com/css?family=Roboto:300,400,700';")
Canvas.backgroundColor = "#303030"
Screen.backgroundColor = "#303030"
Color.main = "#2196f3"
Boxshadow = "0 4px 4px 0 rgba(0, 0, 0, 0.24), 0 0 4px 0 rgba(0, 0, 0, 0.12)"
w = 344 * 2
h = 224 * 2
paperContainer = new Layer
	width: w
	height: h	
	y: 44 * 2
	x: Align.center
	backgroundColor: null
	clip: true
	perspective: 2000
	style:
		borderRadius: "4px"
		boxShadow: "0 4px 4px 0 rgba(0, 0, 0, 0.24), 0 0 4px 0 rgba(0, 0, 0, 0.12)"
	
topFold = new Layer
	parent: paperContainer
	width: w
	height: h / 2
	backgroundColor: Color.main
	originY: 0
	clip: true # to make shadow layer also rounded
	rotationX: 0
	backfaceVisible: false
	html:"THIS SCROLLING ANIMATION PURPOSES ARE STATE, ATTENTION"
	style:
		borderRadius: " 0 0 4px 4px"
		color: "rgba(255,255,255,1)"
		fontFamily: "Roboto"
		textAlign: "center"
		fontSize: "32px"
		boxShadow: "0px 0px 8px 0 rgba(0,0,0,0.24)"
		perspectiveOrigin: "center top"
		letterSpacing: "1px"
		lineHeight: "48px"
		padding: "130px 32px 0"

bottomFold = new Layer
	parent: paperContainer
	width: w
	height: h / 2
	y: h / 2
	backgroundColor: Color.main
	rotationX: 0
	originY: 1
	clip: true # to make light layer also rounded
	backfaceVisible: false
	html:"FEEDBACK AND INDIVIDUALIZATION"
	style:
		borderRadius: " 0 0 4px 4px"
		color: "rgba(255,255,255,1)"
		textAlign: "center"
		perspectiveOrigin: "center bottom"
		color: "rgba(255,255,255,1)"
		fontFamily: "Roboto"
		textAlign: "center"
		fontSize: "32px"
		boxShadow: "0px 0px 8px 0 rgba(0,0,0,0.24)"
		perspectiveOrigin: "center top"
		letterSpacing: "1px"
		lineHeight: "48px"
		padding: "6px 32px 0"

shadow = new Layer
	parent: topFold
	width: w
	height: h/2
	backgroundColor: "rgb(0,0,0)"
	opacity: 0
	
light = new Layer
	parent: bottomFold
	width: w
	height: h/2
	backgroundColor: "rgb(0,0,0)"
	opacity: 0

# Variables
rows = 5
gutter = 16
rowHeight = 160 * 2

# CONTROLLING THE FOLD
controller = new ScrollComponent
	size: Screen.size
	scrollHorizontal: false

handle = new Layer
	width: Screen.width
	height: rows * (rowHeight + gutter)
	parent: controller.content
	backgroundColor: null

# Loop to create row layers
for index in [0...rows]
	cell = new Layer
		width:  w
		height: rowHeight
		y: 300 * 2 + index * (rowHeight + gutter)
		x: Align.center
		parent: controller.content
		backgroundColor: "#424242"
		borderRadius: 4
		style:
			boxShadow: "0 4px 4px 0 rgba(0, 0, 0, 0.24), 0 0 4px 0 rgba(0, 0, 0, 0.12);"

#Interaciton hint
hint = new Layer
	width: Screen.width
	height: 19 
	y: Screen.height - 154
	backgroundColor: null
	html: "Scroll up and down"
	style:
		color: "#bdbdbd"
		fontSize: "28px"
		lineHeight: "200px"
		textAlign: "center"
		fontFamily: "Roboto"
		letterSpacing: "0.7px"
			
controller.onMove ->
	topFold.rotationX = Utils.modulate(controller.scrollY*0.96, [0, 536], [0, -120], true)
	bottomFold.rotationX = Utils.modulate(controller.scrollY, [0, 536], [0, 90], true)
	bottomFold.y = Utils.modulate(bottomFold.rotationX*0.98, [0, 90], [h/2, -h/2-45], true)
	shadow.opacity = Utils.modulate(controller.scrollY, [0, 536], [0, 1], true)
	light.opacity = Utils.modulate(controller.scrollY, [0, 536], [0, 0.9], true)
	

Status_bar = new Layer
	width: 750
	height: 40
	image: "images/Status_bar.png"
