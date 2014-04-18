<%!
	public String getDateImage(String field)
	{
		StringBuffer sb = new StringBuffer("");
		sb.append("<img src='../../../../../EzCommon/JavaScript/Calendar/Themes/icons/calendar7.gif' style='cursor:hand' id='butt"+field+"' border='none' valign='center'>");
		sb.append("<script>var cal = getSetup('"+field+"','butt"+field+"');</script>");
		return sb.toString();
	}	
	public String getDateImageFromToday(String field)
	{
			StringBuffer sb = new StringBuffer("");
			sb.append("<img src='../../../../../EzCommon/JavaScript/Calendar/Themes/icons/calendar7.gif' style='cursor:hand' id='butt"+field+"' border='none' valign='center'>");
			sb.append("<script>var cal = getSetupFromToday('"+field+"','butt"+field+"');</script>");
			return sb.toString();
	}	
%>
<link rel="stylesheet" type="text/css" href="../../../../../EzCommon/JavaScript/Calendar/Themes/system.css">
<script type="text/javascript" src="../../../../../EzCommon/JavaScript/Calendar/utils.js"></script>
<script type="text/javascript" src="../../../../../EzCommon/JavaScript/Calendar/calendar.js"></script>
<script type="text/javascript" src="../../../../../EzCommon/JavaScript/Calendar/calendar-en.js"></script>
<script type="text/javascript" src="../../../../../EzCommon/JavaScript/Calendar/calendar-setup.js"></script>
<script type="text/javascript">
function getSetup(filedName,buttonId)
{
	var cal = new Zapatec.Calendar.setup({
		inputField     : filedName,    	// id of the input field
		ifFormat       : "%m/%d/%Y",   	//  of the input field
		//date	       : "9"+"/"+"12"+"/"+"2006",
		button         : buttonId  // trigger button (well, IMG in our case)		
	});
	return cal;	
}
function getSetupFromToday(filedName,buttonId)
{
	var cal = new Zapatec.Calendar.setup({
		inputField     : filedName,    	// id of the input field
		ifFormat       : "%m/%d/%Y",   	//  of the input field
		//date	       : "9"+"/"+"12"+"/"+"2006",
		button         : buttonId,  // trigger button (well, IMG in our case)		
		dateStatusFunc : disallowDateBefore
	});
	return cal;	
}
var startDate;
var endDate;
var ONEDAY = 3600 * 24;

function disallowDateBefore(date) {
	var dt=date;
	date = date.getTime();
	if ((startDate != null) && (date < (startDate + ONEDAY))) {
		    //start date can't be prior to end date
		    return true; 

	} 
	var now = new Date().getTime();
	if (date < (now - ONEDAY)) {
		    //start date can't be prior to today
		    if((dt.getDate()) != (new Date().getDate()) || ((dt.getMonth()) != (new Date().getMonth())) || ((dt.getYear()) != (new Date().getYear()))){
		    	return true;	
		    }
	}
	return false;
}
</script>