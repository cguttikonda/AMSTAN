var statusMsg = new Array();
statusMsg[0] 	= "Welcome to  EzCommerce Suite......";
var popfont	= "Verdana"
var speed 	= 100 
var pause 	= 1000 
var timerID 	= null
var offset 	= 0

var currentMessage = 0
var bannerRunning  = true

function stopBanner() 
{
	if (bannerRunning)
		clearTimeout(timerID)
	window.status=" "
	bannerRunning = false
}

function startBanner() 
{
	stopBanner()
	showBanner()
}

function showBanner() 
{
	var text = statusMsg[currentMessage]

	// if current message has not finished being displayed
	if (offset < text.length) 
	{
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
	} 
	else 
	{
		// reset offset
		offset = 0

		// increment subscript (index) of current message
		currentMessage++

		// if subscript of current message is out of range
		if (currentMessage == statusMsg.length)
			// wrap around (start from beginning)
			currentMessage = 0

		// recursive call after specified time
		timerID = setTimeout("showBanner()", pause)

		// banner is running
		bannerRunning = true
	}
}
