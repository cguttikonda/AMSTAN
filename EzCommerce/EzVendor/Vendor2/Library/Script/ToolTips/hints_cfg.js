var HINTS_CFG = {
	'top'        : 5, 		// a vertical offset of a hint from mouse pointer
	'left'       : 5, 		// a horizontal offset of a hint from mouse pointer
	'css'        : 'hintsClass', 	// a style class name for all hints, TD object
	'show_delay' : 200, 		// a delay between object mouseover and hint appearing
	'hide_delay' : 2000, 		// a delay between hint appearing and hint hiding
	'wise'       : true,
	'follow'     : true,
	'z-index'    : 0 		// a z-index for all hint layers
},
HINTS_ITEMS = {
	'CAL_TT':wrap("Click here to view Calendar")	
};
var myHint = new THints (HINTS_CFG, HINTS_ITEMS);
function wrap (s_) {		
	return "<table cellpadding='0' cellspacing='0' border='0' style='-moz-opacity:90%;filter:progid:DXImageTransform.Microsoft.dropShadow(Color=#777777,offX=4,offY=4)'><tr><td rowspan='2'><img src='../../Images/ToolTips/1.gif'></td><td><img src='../../Images/ToolTips/pixel.gif' width='1' height='15'></td></tr><tr><td background='../../Images/ToolTips/2.gif' height='28' nowrap>"+s_+"</td><td><img src='../../Images/ToolTips/4.gif'></td></tr></table>"
}