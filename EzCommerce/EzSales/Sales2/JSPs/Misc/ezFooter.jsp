<%@ include file="../../../Includes/JSPs/Lables/iFooter2_Lables.jsp"%>

<html>
<head>
<%
	response.setHeader("Pragma", "No-cache");
	response.setDateHeader("Expires", 0);
	response.setHeader("Cache-Control", "no-cache");
	java.util.Date myDate=new java.util.Date();
	int year	= myDate.getYear()+1900;
	int month	= myDate.getMonth();
	int date	= myDate.getDate();
	int hours	= myDate.getHours();
	int minutes	= myDate.getMinutes();
	int seconds	= myDate.getSeconds();
%>

<!--
<Script src = ../../Library/JavaScript/Misc/ezLiveClock.js></Script>-->
<%@ include file="../../../Includes/Lib/ezAddBannerDir.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iFooter_POPHelp.jsp"%>
<Script>
var processRequest;
var counter = 0;
	function ezAutoLogout()
	{
		try
		{
			processRequest = null;
			processRequest = new ActiveXObject("Msxml2.XMLHTTP");
		}
		catch(e)
		{
			try
			{
				processRequest=new ActiveXObject("Microsoft.XMLHTTP");
			}
			catch(oc)
			{
				processRequest=null;
			}
		}

		if(!processRequest&&typeof XMLHttpRequest!="undefined")
		{
			processRequest=new XMLHttpRequest();
		}

		
		var url="http://"+location.host+"/KissUSA/EzCommerce/EzCommon/JSPs/ezAutoLogout.jsp?noCache='"+((new Date()).valueOf())+ "'&counter="+counter;
		if(processRequest!=null)
		{
			processRequest.onreadystatechange = Process;
			processRequest.open("GET", url, false);
			processRequest.send(null);
			counter++;
		}
	}

	function Process()
	{
		if (processRequest.readyState == 4)
		{
			if (processRequest.status == 200)
			{
				if(processRequest.responseText!="")
				{
					performAutoLogout(processRequest.responseText)
				}
			}
		}

	}

	function performAutoLogout(duration)
	{
		var checkDuration = '15'
		if(counter > 1)
			checkDuration = checkDuration-1

		if(duration >= checkDuration)
		{
			parent.location.href="ezLogout.jsp?AUTOLOGOUT=Y";
		}
		else
		{

			setTimeout("ezAutoLogout()",60000);
		}
	}
	
	function show_clock(syear,smonth,smday,shours,sminutes,sseconds)
	{	
		
		/////////////// CONFIGURATION /////////////////////////////
	
		// Set the clock's font face:
		var myfont_face = "arial";
	
		// Set the clock's font size (in point):
		var myfont_size = "9";
	
		// Set the clock's font color:
		var myfont_color = "#FFFFFF";//00355D
	
		// Set the clock's background color:
		var myback_color = "#FFFFFF";
	
		// Set the text to display before the clock:
		var mypre_text = "";
	
		// Set the width of the clock (in pixels):
		var mywidth = 300;
	
		// Display the time in 24 or 12 hour time?
		// 0 = 24, 1 = 12
		var my12_hour = 0;
	
		// How often do you want the clock updated?
		// 0 = Never, 1 = Every Second, 2 = Every Minute
		// If you pick 0 or 2, the seconds will not be displayed
		var myupdate = 1;
	
		// Display the date?
		// 0 = No, 1 = Yes
		var DisplayDate = 1;
	
		/////////////// END CONFIGURATION /////////////////////////
		///////////////////////////////////////////////////////////
	
		// Browser detect code
		var ie4=document.all
		var ns4=document.layers
		var ns6=document.getElementById&&!document.all
	
	
		// Global varibale definitions:
	
		var dn = "";
		var mn = "th";
		var old = "";
	
		// The following arrays contain data which is used in the clock's
		// date function. Feel free to change values for Days and Months
		// if needed (if you wanted abbreviated names for example).
		var DaysOfWeek = new Array(7);
			DaysOfWeek[0] = "Sunday";
			DaysOfWeek[1] = "Monday";
			DaysOfWeek[2] = "Tuesday";
			DaysOfWeek[3] = "Wednesday";
			DaysOfWeek[4] = "Thursday";
			DaysOfWeek[5] = "Friday";
			DaysOfWeek[6] = "Saturday";
	
		var MonthsOfYear = new Array(12);
			MonthsOfYear[0] = "Jan";
			MonthsOfYear[1] = "Feb";
			MonthsOfYear[2] = "Mar";
			MonthsOfYear[3] = "Apr";
			MonthsOfYear[4] = "May";
			MonthsOfYear[5] = "Jun";
			MonthsOfYear[6] = "Jul";
			MonthsOfYear[7] = "Aug";
			MonthsOfYear[8] = "Sep";
			MonthsOfYear[9] = "Oct";
			MonthsOfYear[10] = "Nov";
			MonthsOfYear[11] = "Dec";
	
		// This array controls how often the clock is updated,
		// based on your selection in the configuration.
		var ClockUpdate = new Array(3);
			ClockUpdate[0] = 0;
			ClockUpdate[1] = 1000;
			ClockUpdate[2] = 60000; 
		// For Version 4+ browsers, write the appropriate HTML to the
		// page for the clock, otherwise, attempt to write a static
		// date to the page.
		
			//if (ie4||ns6) { document.write('<span id="LiveClockIE" style="width:'+mywidth+'px; background-color:'+myback_color+'"></span>'); }
			//else if (document.layers) { document.write('<ilayer bgColor="'+myback_color+'" id="ClockPosNS" visibility="hide"><layer width="'+mywidth+'" id="LiveClockNS"></layer></ilayer>'); }
			//else { old = "true"; show_clock(); }
			
			
			if (old == "die") { return; }
	
			//alert(syear)
			//alert(smonth)
			//alert(smday)
			//alert(shours)
			//alert(sminutes)
			//alert(sseconds)
	
		//show clock in NS 4
			if (ns4)
			document.ClockPosNS.visibility="show"
		// Get all our date variables:
			var Digital = null;
			if(syear == null)
				Digital = new Date();
			else	
				Digital = new Date(syear,smonth,smday,shours,sminutes,sseconds); 
			var day = Digital.getDay();
			var mday = Digital.getDate();
			var month = Digital.getMonth(); 
			var year  = Digital.getYear();
			if(year<1900){ year=year+1900; }
			var hours = Digital.getHours();
	
			var minutes = Digital.getMinutes();
			var seconds = Digital.getSeconds();
	
		// Fix the "mn" variable if needed:
			if (mday == 1) { mn = "st"; }
			else if (mday == 2) { mn = "nd"; }
			else if (mday == 3) { mn = "rd"; }
			else if (mday == 21) { mn = "st"; }
			else if (mday == 22) { mn = "nd"; }
			else if (mday == 23) { mn = "rd"; }
			else if (mday == 31) { mn = "st"; }
	
		// Set up the hours for either 24 or 12 hour display:
			if (my12_hour) {
				dn = "AM";
				if (hours > 12) { dn = "PM"; hours = hours - 12; }
				if (hours == 0) { hours = 12; }
			} else {
				dn = "";
			}
			if (minutes <= 9) { minutes = "0"+minutes; }
			if (seconds <= 9) { seconds = "0"+seconds; }
		// This is the actual HTML of the clock. If you're going to play around
		// with this, be careful to keep all your quotations in tact.
			myFontStart = '<font style="color:'+myfont_color+'; font-family:'+myfont_face+'; font-size:'+myfont_size+'pt;">';
			myFontEnd = '</font>';
			myclock = '';
			myclock += mypre_text;
			myclock += hours+':'+minutes;
			if ((myupdate < 2) || (myupdate == 0)) { myclock += ':'+seconds; }
			myclock += ' '+dn;
			if (DisplayDate) 
			{ 
				myclock = DaysOfWeek[day]+" "+mday+mn+' '+MonthsOfYear[month] + ","+year+" "+myclock; 
			}
			myclock = myFontStart+myclock+myFontEnd;
	
			if (old == "true") 
			{
				document.write(myclock);
				old = "die";
				return;
			}
	
			//document.getElementByName("LiveClock")[0].innerHTML = "<b>"+myclock+"<b>&nbsp;&nbsp;";
			document.getElementById("LiveClock").innerHTML = "<b>"+myclock+"<b>&nbsp;&nbsp;";	
		if (myupdate != 0) { setTimeout("show_clock("+year+","+month+","+mday+","+hours+","+minutes+","+(++seconds)+")",ClockUpdate[myupdate]); }
	
	}
	

	
	
	
</Script>
<Style>
	
	.footerbody
	{
		background-color:#227A7A;
	}
	.footer
	{
		   filter:progid:DXImageTransform.Microsoft.Gradient(GradientType=0,StartColorStr='#227A7A',EndColorStr='#227A7A');
	}
	.footer1
	{
		font-family:  comicsans; 
		font-size: 15px;
		font-weight:bold;
		font-style: normal; 
		color: #FFFFFF;
		text-decoration:none;
		FONT-WEIGHT:bold;
	}
	.footer_logo
	{
		font-family:  comicsans; 
		font-size: 13px;
		font-weight:bold;
		font-style: normal; 
		color: #FFFFFF;
		text-decoration:none;
		FONT-WEIGHT:bold;
	}
	.footerpowerby
	{
		font-family:  Verdana, Arial; 
		font-size: 9px; 
		font-style: normal; 
		color: #FFFFFF;
	}
	.footerlinkcell
	{
		font-family:  Verdana, Arial; 
		font-size: 10px; 
		font-style: normal; 
		color: #FFFFFF;
	}
	
	a:active {text-decoration: none;color: #FFFFFF;}
	a:active {text-decoration: none;color: #FFFFFF;}
	a:hover  {FONT-WEIGHT:bold;color: #FFFFFF;}
	a:link   {text-decoration: none;color: #FFFFFF;}
</Style>
</head>
<Body topmargin="0" leftmargin=0 marginheight="1" class=footerbody onLoad="show_clock(<%=year%>,<%=month%>,<%=date%>,<%=hours%>,<%=minutes%>,<%=seconds%>);">
<Form name="footer" method="post" action="../Misc/ezSalesHome.jsp" target="_top">
<Div style='position:absolute;width:100%;top:0%;left:0%'>
<Table width="100%" height=100% border="0" cellspacing="0" cellpadding="0" align=left>
<Tr>
	<Td width="2%" align="center" valign="top">
		<a href="javascript:void(0);" onMouseOver="ezShowHelp();window.status='Context Help'; return true;" onMouseOut = "ezShowHelpOut();window.status=' '; return true">
			 <font class=footer1>?</font>
		</a>
	</Td>
	<Td valign="top" align="right">
		<font class=footerpowerby> Powered By </font><a target="The Hackett Group" href="http://www.thehackettgroup.com"><font  class=footerlinkcell><b>The Hackett Group</b></font></a><font class=footerpowerby>|&nbsp;Copyright&nbsp;&copy;&nbsp;2010. All Rights Reserved.</font>
	</Td>
	<Td width=35% align=right>
		<Div id='LiveClock'></Div>
	</Td>
<%		
	if(!"CU".equals((String)session.getValue("UserRole")) && !"CUSR".equals((String)session.getValue("UserRole")))
	{
%>			
		<Td class=footerhelp width="3%" height="15" align="right"><a href="JavaScript:void(0)" onMouseover="window.status='Click here to go to home page wherever you may be in this whole navigation'; return true" onMouseout="window.status=' '; return true" onClick="formSubmit()"><img SRC="../../../../EzCommon/Images/Banner/home.gif" width="20" height="15" hspace="6" alt="Home" title="Home" border="0"></a></td>
<%		
	}
%>		
</Tr>

</Table>
</Div>
</Form>
</Body>
</Html>

