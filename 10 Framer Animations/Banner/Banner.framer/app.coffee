# General settings
Color.grey = "#BDBDBD"
Font = "Roboto, Helvetica, Arial, sans-serif"
w = 344 * 2
h = 180 * 2
Canvas.backgroundColor = Color.BG
Screen.backgroundColor = Color.BG
Dots = []
DotsCover = []
Pages = []
	
# Variables
pageCount = 3
gutter = 60

Utils.insertCSS("@import 'https://fonts.googleapis.com/css?family=Roboto:300,400,700';")
Canvas.backgroundColor = "#303030"
Screen.backgroundColor = "#303030"
Color.main = "#2196f3"
Boxshadow = "0 4px 4px 0 rgba(0, 0, 0, 0.24), 0 0 4px 0 rgba(0, 0, 0, 0.12)"
w = 344 * 2
h = 224 * 2

# Create PageComponent
pageScroller = new PageComponent
	point: Align.center
	width: Screen.width
	height: Screen.height
	scrollVertical: false
	clip: false

# Loop to create pages
for index in [0...pageCount]
	page = new Layer
		size: pageScroller.size
		x: (pageScroller.width + gutter) * index
		parent: pageScroller.content
		html: "THIS BANNER ANIMATION PURPOSES ARE ATTENTION, STATE, AND INDIVIDUALIZATION"
		style:
			fontFamily: "Roboto"
			fontSize: "32px"
			lineHeight: "48px"
			letterSpacing: "0.5px"
			padding:"604px 64px"
			textAlign: "center"
			color: "rgba(255, 255, 255, 0.87)"
	Pages.push(page)

Pages[0].backgroundColor = "#303030"
Pages[1].backgroundColor = "#616161"
Pages[2].backgroundColor = "#9e9e9e"

dotWidth = 36
dotGutter = 16*2

dotsWrapper = new Layer
	x: Align.center
	y: Screen.height - 80
	backgroundColor: null
	width: dotWidth * pageCount + dotGutter * (pageCount-1)
		
for index in [0...pageCount]
	dot = new Layer
		parent: dotsWrapper
		width: dotWidth
		height: dotWidth
		borderRadius: dotWidth/2
		backgroundColor: "#e2e2e2"
		clip: true
		x: (dotWidth + dotGutter) * index
	Dots.push(dot)
		
	dotCover = new Layer
		parent: dot
		width: dotWidth
		height: dotWidth
		borderRadius: dotWidth/2
		backgroundColor: Color.main
		scale: 0.5
		opacity: 0.5
	DotsCover.push(dotCover)
	dotCover.visible = false

Status_bar = new Layer
	width: 750
	height: 40
	image: "images/Status_bar.png"
				
# Sector BG
Sector = (deg, obj) ->
	if deg <= 180
		obj.style.backgroundImage = "linear-gradient(#{90+deg}deg,transparent 50%, #2196F3 50%),linear-gradient(90deg, #2196F3 50%, transparent 50%)"
	else
		obj.style.backgroundImage = "linear-gradient(#{deg-90}deg,transparent 50%, #eee 50%),linear-gradient(90deg, #2196F3 50%, transparent 50%)"

Bubble = (layer) ->
	layer.visible = true
	animationA = new Animation layer,
		scale: 0.1
		opacity: 1
		options:
			time: 0.2
			curve: Bezier.easeInOut
			
	animationB = new Animation layer,
		scale: 1.2
		opacity: 0.4
		options:
			time: 0.3
			curve: Bezier.easeOut
	
	animationA.start()
	animationA.on Events.AnimationEnd, ->
		animationA.reset()
		animationB.start()
			
	animationB.on Events.AnimationEnd, ->
		animationB.reset()
		layer.visible = false
		
# Execute animation
degree = 0
number = 0
Utils.interval 0.0417, ->
	if degree <= 360
		degree += 7.5
	else
		degree = 0
		Dots[number].style.backgroundImage = null
		Bubble(DotsCover[number])		
		number = (number+1) % 3
	Sector(degree, Dots[number])

Utils.interval 2.4, ->
	if pageScroller.currentPage.id is 5
		pageScroller.snapToPage(Pages[0],false)
	else			pageScroller.snapToNextPage("right",true,curve:Bezier.easeOut,time:0.2)