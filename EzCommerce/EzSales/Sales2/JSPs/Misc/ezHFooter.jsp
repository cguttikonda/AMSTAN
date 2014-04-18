<%@ include file="../../../Includes/JSPs/Lables/iFooter2_Lables.jsp"%>
<html>
<head>
<%
	response.setHeader("Pragma", "No-cache");
	response.setDateHeader("Expires", 0);
	response.setHeader("Cache-Control", "no-cache");
%>

<%@ include file="../../../Includes/Lib/ezAddBannerDir.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iFooter_POPHelp.jsp"%>

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
<Body topmargin="0" leftmargin=0 marginheight="1" class=footerbody>

<Div style='position:absolute;width:100%;top:0%;left:0%'>
<Table width="100%" height=100% border="0" cellspacing="0" cellpadding="0" align=left>
<Tr class=footer>
	<Td width="2%" align="center" valign="top">
		<a href="javascript:void(0);" onMouseOver="ezShowHelp();window.status='Context Help'; return true;" onMouseOut = "ezShowHelpOut();window.status=' '; return true">
			 <font class=footer1>?</font>
		</a>
	</Td>
	<Td valign="top" align="right">
		<font class=footerpowerby> Powered By </font><a target="The Hackett Group" href="http://www.thehackettgroup.com"><font  class=footerlinkcell><b>The Hackett Group</b></font></a><font class=footerpowerby>|&nbsp;Copyright&nbsp;&copy;&nbsp;2010. All Rights Reserved.</font>
	</Td>
	<Td width=35% align=right id="LiveClock" class=footerpowerby>
	</Td>
		
</Tr>
</Table>
</Div>

</Body>
</Html>








