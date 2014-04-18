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
<Style>
	.footerbody
	{
		background-color:#FFFFFF;
	}
	#footer
	{
		   filter:progid:DXImageTransform.Microsoft.Gradient(GradientType=0,StartColorStr='#FFFFFF',EndColorStr='#FF7575');
	}
	.footer1
	{
		font-family:  comicsans; 
		font-size: 20px;
		gont-weight:bold;
		font-style: normal; 
		color: #660000;
		text-decoration:none;
		FONT-WEIGHT:bold;
	}
	.footerpowerby
	{
		font-family:  Verdana, Arial; 
		font-size: 9px; 
		font-style: normal; 
		color: #000000;
	}
	.footerlinkcell
	{
		font-family:  Verdana, Arial; 
		font-size: 10px; 
		font-style: normal; 
		color: #660000;
	}
	a:active {text-decoration: none;color: #FFFFFF;}
	a:active {text-decoration: none;color: #FFFFFF;}
	a:hover  {FONT-WEIGHT:bold;color: #FFFFFF;}
	a:link   {text-decoration: none;color: #FFFFFF;}
</Style>
<Script src = ../../Library/JavaScript/Misc/ezLiveClock.js></Script>
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
</Script>


</head>
<Body topmargin="0" leftmargin=0 marginheight="1" class=footerbody onLoad="show_clock(<%=year%>,<%=month%>,<%=date%>,<%=hours%>,<%=minutes%>,<%=seconds%>);">
<Form name="footer" method="post" action="../Misc/ezSalesHome.jsp" target="_top">
<TABLE cellSpacing=0 cellPadding=0 width="100%" height=100% align=center border=0 >
<TR>
<TD valign="top" background='../../../../EzCommon/Images/Footer/bottom.jpg' height=100%>
	<Table width="100%" border="0" cellspacing="0" cellpadding="0" align=left>
	<Tr>
		<Td width="2%" align="center" valign="top">
			<a href="javascript:void(0);" onMouseOver="ezShowHelp();window.status='Context Help'; return true;" onMouseOut = "ezShowHelpOut();window.status=' '; return true">
				 <font class=footer1>?</font>
			</a>
		</Td>
		<Td valign="top" align="right">
			<font class=footerpowerby> Powered By </font><a target="Answerthink" href="http://www.answerthink.com"><font  class=footerlinkcell><b>Answerthink</b></font></a><font class=footerpowerby>|&nbsp;Copyright&nbsp;&copy;&nbsp;2006. All Rights Reserved.</font>
		</Td>
		<Td width=35% align=right id="LiveClock" class=footerbottam>
		</Td>
<%		if(!"CU".equals((String)session.getValue("UserRole")))
		{
%>			<Td class=footerhelp width="3%" height="15" align="right"><a href="JavaScript:void(0)" onMouseover="window.status='Click here to go to home page wherever you may be in this whole navigation'; return true" onMouseout="window.status=' '; return true" onClick="formSubmit()"><img SRC="../../../../EzCommon/Images/Banner/home.gif" width="20" height="15" hspace="6" alt="Home" title="Home" border="0"></a></td>
<%		}
%>		

	</Tr>
	</Table>
	
</TD></TR>	
</TABLE>
</Form>
</Body>
</Html>








