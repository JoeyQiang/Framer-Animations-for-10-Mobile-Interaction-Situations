InputModule = require "input"

# General settings
Utils.insertCSS("@import 'https://fonts.googleapis.com/css?family=Roboto:300,400,700';")
Canvas.backgroundColor = "#303030"
Screen.backgroundColor = "#303030"
Color.main = "#2196f3"
Boxshadow = "0 4px 4px 0 rgba(0, 0, 0, 0.24), 0 0 4px 0 rgba(0, 0, 0, 0.12)"
w = 344 * 2
h = 224 * 2

pageScroller = new PageComponent
	point: Align.center
	width: Screen.width
	height: Screen.height
	scrollVertical: false
	clip: false
	
portrait = new Layer
	x: Align.center
	y: 126 * 2
	borderRadius: "50%"
	width: 96 * 2
	height: 96 * 2
	backgroundColor: "#757575"
	style:
		boxShadow: Boxshadow	

portraitOverlay = new Layer
	parent: portrait
	borderRadius: "50%"
	width: 96 * 2
	height: 96 * 2
	backgroundColor: "#E0E0E0"	

portraitOverlay.states =
	one:
		opacity: 0
		scale: 0
		animationOptions:
			curve: Bezier.easeIn
			time: 0.15
	two:
		opacity: 1
		scale: 1
		animationOptions:
			curve: Bezier.easeIn
			time: 0.15

portraitOverlay.stateSwitch("one")	

back  = new Layer
	x: 24 * 2
	y: 36 * 2
	width: 48
	height: 48
	image: "images/ic_arrow_back_black_24px.svg"

back.states = 
	hide:
		opacity: 0
	show:
		opacity: 1

back.stateSwitch("hide")
	
slideContentOne = new Layer
	parent: pageScroller.content
	width: Screen.width
	height: Screen.height
	backgroundColor: null

slideContentTwo = new Layer
	width: Screen.width
	height: Screen.height
	backgroundColor: null

inputEmail = new Layer
	parent: slideContentOne
	y: 246 * 2
	x: Align.center
	width: 328 * 2
	height: 48 * 2
	backgroundColor: null
	style:
		borderBottom:"solid 2px #2196f3"

inputPasscode = new Layer
	parent: slideContentTwo
	y: 254 * 2
	x: Align.center
	width: 328 * 2
	height: 48 * 2
	backgroundColor: null
	style:
		borderBottom:"solid 2px #2196f3"
		
buttonNext = new Layer
	parent: slideContentOne
	y: 319 * 2
	x: Align.center
	width: 329 * 2
	height: 40 * 2
	backgroundColor: Color.main
	html: "NEXT"
	borderRadius: 4
	style:
		textAlign: "center"
		lineHeight: "80px"
		fontSize: "28px"
		fontFamily: "Roboto"
		letterSpacing: "0.5px"
		color: "rgba(255, 255, 255, 0.87)"

buttonNext.states =
	up:
		style:
			backgroundColor: Color.main
	down:
		shadowY: 3
		style:
			backgroundColor: "#4fa1e2"
			boxShadow: "0 16px 16px 0 rgba(0, 0, 0, 0.24), 0 0 16px 0 rgba(0, 0, 0, 0.12)"

buttonSignUp = new Layer
	parent: slideContentTwo
	y: 327 * 2
	x: Align.center
	width: 329 * 2
	height: 40 * 2
	backgroundColor: Color.main
	html: "SIGN UP"
	borderRadius: 4
	style:
		textAlign: "center"
		lineHeight: "80px"
		fontSize: "28px"
		fontFamily: "Roboto"
		letterSpacing: "0.5px"
		color: "rgba(255, 255, 255, 0.87)" 	

account = new Layer	
	parent: slideContentTwo
	y: 230 * 2
	x: 65
	width: 620
	height: 34
	backgroundColor: null
	html: "joeyqiang@gmail.com"
	style:
		textAlign: "center"
		fontFamily: "Roboto"
		fontSize: "28px"
		color: "#fff"

pageScroller.addPage(slideContentTwo,"right")

buttonNext.on Events.MouseDown, () ->
	buttonNext.stateSwitch("down")	

buttonNext.on Events.MouseUp, () ->
	buttonNext.stateSwitch("up")
	pageScroller.snapToPage(slideContentTwo)
	back.stateSwitch("show")
	portraitOverlay.animate("two")	

back.on Events.Click, () ->
	pageScroller.snapToPage(slideContentOne)
	back.stateSwitch("hide")	
	portraitOverlay.animate("one")	

emailInput = new InputModule.Input
	parent: slideContentOne
	virtualKeyboard: false
	x: 40
	y: 514
	width: 620
	height: 40 * 2
	placeholder: "Email"
	placeholderColor: "rgba(255, 255, 255, 0.6)"
	fontSize: 32

emailInput.style =
	color: Color.main
	textShadow: "0 0 0 rgba(255, 255, 255, 0.6)"
	webkitTextFillColor: "transparent"

paswordInput = new InputModule.Input
	parent: slideContentTwo
	virtualKeyboard: false
	x: 40
	y: 530
	width: 620
	height: 40 * 2
	placeholder: "Password"
	placeholderColor: "rgba(255, 255, 255, 0.6)"
	fontSize: 32

paswordInput.style =
	color: Color.main
	textShadow: "0 0 0 rgba(255, 255, 255, 0.6)"
	webkitTextFillColor: "transparent"

Status_bar = new Layer
	width: 750
	height: 40
	image: "images/Status_bar.png"

hint = new Layer
	width: 312 * 2
	x: Align.center
	y: Screen.height - 182
	backgroundColor: null
	html: "THIS FORM ANIMATION PURPOSES ARE STATE, ATTENTION, FEEDBACK AND INDIVIDUALIZATION"
	style:
		fontFamily: "Roboto"
		fontSize: "32px"
		lineHeight: "48px"
		letterSpacing: "0.5px"
		textAlign: "center"
		color: "rgba(255, 255, 255, 0.87)"


