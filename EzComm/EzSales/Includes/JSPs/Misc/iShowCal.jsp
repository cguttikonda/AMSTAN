
<%@ page import = "java.util.*" %>

<%!
	public String getDateImage(String field)
	{
		StringBuffer sb = new StringBuffer("");
		sb.append("<img src='../../../Sales/Library/Script/Calendar/Themes/icons/calendar7.gif' style='cursor:pointer' id='butt"+field+"' border='none' valign='center'>");
		sb.append("<script>var cal = getSetup('"+field+"','butt"+field+"');</script>");
		return sb.toString();
	}	
	public String getDateImageFromToday(String field)
	{
		StringBuffer sb = new StringBuffer("");
		sb.append("<img src='../../../Sales/Library/Script/Calendar/Themes/icons/calendar7.gif' style='cursor:pointer' id='butt"+field+"' border='none' valign='center'>");
		sb.append("<script>var cal = getSetupFromToday('"+field+"','butt"+field+"');</script>");
		return sb.toString();
	}
	public String getDateImageFromTomorrow(String field)
	{
		StringBuffer sb = new StringBuffer("");
		sb.append("<img src='../../../Sales/Library/Script/Calendar/Themes/icons/calendar7.gif' style='cursor:pointer' id='butt"+field+"' border='none' valign='center'>");
		sb.append("<script>var cal = getSetupFromTomorrow('"+field+"','butt"+field+"');</script>");
		return sb.toString();
	}
%>
<%
	String calToolTip = "";
	java.util.Calendar cdObj = java.util.Calendar.getInstance();
	int cYear = cdObj.get(Calendar.YEAR);
	int cMonth = cdObj.get(Calendar.MONTH);
	int cDate = cdObj.get(Calendar.DATE);

	java.util.Hashtable thHash = new java.util.Hashtable();
	
	thHash.put("GREEN","9");
	thHash.put("DARKBLUE","12");
	thHash.put("YELLOW","8");
	thHash.put("PINK","5");
	thHash.put("BROWN","1");
	thHash.put("BLUE","6");




	String calTheme ="1",calThemeName ="system";
	String styleDir = (String)session.getValue("userStyle");
	if(styleDir==null) 
		styleDir ="BROWN";
	else 
		styleDir = styleDir.trim();

	calTheme = (String)thHash.get(styleDir.toUpperCase());
	calTheme = "1";
	if("1".equals(calTheme))	calThemeName ="system";
	else if("2".equals(calTheme))	calThemeName ="aqua";
	else if("3".equals(calTheme))	calThemeName ="wood";
	else if("4".equals(calTheme))	calThemeName ="winter";
	else if("5".equals(calTheme))	calThemeName ="win2k";
	else if("6".equals(calTheme))	calThemeName ="winxp";
	else if("7".equals(calTheme))	calThemeName ="maroon";
	else if("8".equals(calTheme))	calThemeName ="yellow";
	else if("9".equals(calTheme))	calThemeName ="greengrass";
	else if("10".equals(calTheme))	calThemeName ="forest";
	else if("11".equals(calTheme))	calThemeName ="bluexp";
	else if("12".equals(calTheme))	calThemeName ="fancyblue";
	else				calThemeName ="green";
%>


<link rel="stylesheet" type="text/css" href="../../Library/Script/Calendar/Themes/<%=calThemeName%>.css">
<script type="text/javascript" src="../../Library/Script/Calendar/utils.js"></script>
<script type="text/javascript" src="../../Library/Script/Calendar/calendar.js"></script>
<script type="text/javascript" src="../../Library/Script/Calendar/calendar-en.js"></script>
<script type="text/javascript" src="../../Library/Script/Calendar/calendar-setup.js"></script>
<script type="text/javascript">
function getSetup(filedName,buttonId)
{
	var cal = new Zapatec.Calendar.setup({
		inputField     : filedName,    	// id of the input field
		ifFormat       : "%m/%d/%Y",   	//  of the input field
		//date		: "<%=cMonth%>"+"/"+"<%=cDate%>"+"/"+"<%=cYear%>",
		button         : buttonId  // trigger button (well, IMG in our case)		
	});
	return cal;	
}
function getSetupFromToday(filedName,buttonId)
{
	var cal = new Zapatec.Calendar.setup({
		inputField     : filedName,    	// id of the input field
		ifFormat       : "%m/%d/%Y",   	//  of the input field
		//date	       : "<%=cMonth%>"+"/"+"<%=cDate%>"+"/"+"<%=cYear%>",
		button         : buttonId,  // trigger button (well, IMG in our case)		
		dateStatusFunc : disallowDateBefore
	});
	return cal;	
}
function getSetupFromTomorrow(filedName,buttonId)
{
	var cal = new Zapatec.Calendar.setup({
		inputField     : filedName,    	// id of the input field
		ifFormat       : "%m/%d/%Y",   	//  of the input field
		//date	       : "<%=cMonth%>"+"/"+"<%=cDate%>"+"/"+"<%=cYear%>",
		button         : buttonId,  // trigger button (well, IMG in our case)		
		dateStatusFunc : disallowDateToday
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
function disallowDateToday(date) {
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
	return (((dt.getDate()) == (new Date().getDate()) && (dt.getMonth()) == (new Date().getMonth()) && (dt.getYear()) == (new Date().getYear())) || dt.getDay() == 0 || dt.getDay() == 6) ? true : false;
	return false;
}
</script>
