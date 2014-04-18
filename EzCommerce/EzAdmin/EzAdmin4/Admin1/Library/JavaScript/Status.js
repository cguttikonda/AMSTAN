var ar=new Array();
ar[0]="Welcome to EzCommerce Administration Module - Powered by Answerthink (India) Ltd.";

// set speed of banner (pause in milliseconds between characters) 
var speed =100 // decrease value to increase speed (must be positive)

// set pause between completion of message and beginning of following message
var pause = 1000 // increase value to increase pause

// set initial values
var timerID = null
var bannerRunning = false
popfont="Verdana"
Text1="Microsoft Internet Explorer..Add Maintenance Order"
//declarations...................................

// set index of first message to be displayed first
var currentMessage = 0

// set index of last character to be displayed first
var offset = 0

// stop the banner if it is currently running
function stopBanner() {
	// if banner is currently running
	if (bannerRunning)
		// stop the banner
		clearTimeout(timerID)
		//clear the status
		window.status=" "

	// timer is now stopped
	bannerRunning = false
}

// start the banner
function startBanner() {
	// make sure the banner is stopped
	stopBanner()

	// start the banner from the current position
	showBanner()
}

// type-in the current message
function showBanner() {
	// assign current message to variable
	var text = ar[currentMessage]

	// if current message has not finished being displayed
	if (offset < text.length) {
		// if last character of current message is a space
		if (text.charAt(offset) == " ")
			// skip the current character
			offset++			

		// assign the up-to-date to-be-displayed substring
		// second argument of method accepts index of last character plus one
		var partialMessage = text.substring(0, offset + 1) 

		// display partial message in status bar
		window.status = partialMessage

		// increment index of last character to be displayed
		offset++ // IE sometimes has trouble with "++offset"

		// recursive call after specified time
		timerID = setTimeout("showBanner()", speed)

		// banner is running
		bannerRunning = true
	} else {
		// reset offset
		offset = 0

		// increment subscript (index) of current message
		currentMessage++

		// if subscript of current message is out of range
		if (currentMessage == ar.length)
			// wrap around (start from beginning)
			currentMessage = 0

		// recursive call after specified time
		timerID = setTimeout("showBanner()", pause)

		// banner is running
		bannerRunning = true
	}
}