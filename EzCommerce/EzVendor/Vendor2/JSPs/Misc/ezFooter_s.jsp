<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
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
<Html>
<Head>
<Script src = ../../Library/JavaScript/ezHelpScript.js></Script>
<Script src = ../../Library/JavaScript/ezHelpArray.js></Script>
<Script src = ../../Library/JavaScript/Misc/ezLiveClock.js></Script>
<!---- Auto Logout Script -->
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


		var url="http://"+location.host+"/j2ee/EzCommerce/EzCommon/JSPs/ezAutoLogout.jsp?noCache='"+((new Date()).valueOf())+ "'&counter="+counter;
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
		var checkDuration = '10'
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
</SCript>
<Script>
var ezPageHelp = "Default Help.............."
function ezShowHelp()
{
	try{
	
		var docPath = top.display.document;
		divToPopUp=docPath.getElementById("ezPageHelp");
		listBoxIds=docPath.getElementsByTagName("select")
		if(listBoxIds!=null)
		{
			 for(i=0;i<listBoxIds.length;i++)
			{
				if(listBoxIds[i].id=="ShowHelp")
				listBoxIds[i].style.width="0%"
			}
		}
		if(divToPopUp==null)
		{
			divToPopUp=docPath.createElement("DIV");
			with(divToPopUp)
			{
				id="ezPageHelp";
				style.position="absolute";
				innerHTML="EzCommerce";
				style.visibility="visible";
				style.zindex=600
				//style.backgroundColor="#155293"
			}
			docPath.body.appendChild(divToPopUp);
		}
		myUrl=docPath.location.href;
		myUrl=myUrl.substring(myUrl.lastIndexOf("/",myUrl.indexOf(".",myUrl.indexOf("EzCommerce")))+1,myUrl.length);
		myURL1=myUrl.substring(myUrl.lastIndexOf("/",myUrl.indexOf("."))+1,myUrl.indexOf("."));
		flag=true
		for(i=0;i<myKeys.length;i++)
		{
			if(myKeys[i].helpKey.toUpperCase()==myURL1.toUpperCase())
			{
				myMsg=myKeys[i].helpText
				flag=false
				break;
			}
		}
		if(flag)
		{
			myMsg=ezPageHelp;
		}
		ezPOPUp(myMsg,divToPopUp);
	}catch(myerror){
	}
}
function ezShowHelpOut()
{
	try{
		ezPOPOut()
	}catch(myerror) { }
}

function formSubmit()
{
	document.forms[0].target="_parent";
	document.forms[0].action="ezMainMenuframeset.jsp";
	document.footer.submit();
}
</Script>
<Style>
.footerbody
{
	background-color:#D8DBC7;
}
.footer
{
	   filter:progid:DXImageTransform.Microsoft.Gradient(GradientType=0,StartColorStr='#FFFFFF',EndColorStr='#B1B88E');
}
.footer1
{
	font-family:  comicsans; 
	font-size: 15px;
	font-weight:bold;
	font-style: normal; 
	color: #CED2B8;
	text-decoration:none;
	FONT-WEIGHT:bold;
}
.footer_logo
{
	font-family:  comicsans; 
	font-size: 13px;
	font-weight:bold;
	font-style: normal; 
	color: #353727;
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
	color: #23251A;
}
a:active {text-decoration: none;color: #FFFFFF;}
a:active {text-decoration: none;color: #FFFFFF;}
a:hover  {FONT-WEIGHT:bold;color: #FFFFFF;}
a:link   {text-decoration: none;color: #FFFFFF;}
</Style>
</Head>
<Body topmargin="0" leftmargin=0 marginheight="1" class=footerbody onLoad="show_clock(<%=year%>,<%=month%>,<%=date%>,<%=hours%>,<%=minutes%>,<%=seconds%>);">
<Div style='position:relative;width:100%;top:0%;left:0%;'>
<TABLE cellSpacing=0 cellPadding=0 width="100%" height=100% align=center border=0 >
<Tr >
<Td class=footer height=8%>&nbsp;</Td>
</Tr>
<TR>
<TD align=center>
	<img src="../../../../EzCommon/Images/Banner/b_sa.jpg" width=100% >
</TD>	
</TR>	
</TABLE>
</Div>


<Div style='position:absolute;width:100%;top:0%;left:0%'>
<Table width="100%" height=100% border="0" cellspacing="0" cellpadding="0" align=left>
<Tr>
	<Td width="2%" align="center" valign="top">
		<a href="javascript:void(0);" onMouseOver="ezShowHelp();window.status='Context Help'; return true;" onMouseOut = "ezShowHelpOut();window.status=' '; return true">
			 <font class=footer1>?</font>
		</a>
	</Td>
	<Td valign="top" align="right">
		<font class=footerpowerby> Powered By </font><a target="Answerthink" href="http://www.answerthink.com"><font  class=footerlinkcell><b>Answerthink</b></font></a><font class=footerpowerby>|&nbsp;Copyright&nbsp;&copy;&nbsp;2006. All Rights Reserved.</font>
	</Td>
	<Td width=35% align=right id="LiveClock" class=footerpowerby>
	</Td>
</Tr>
<Tr>
	<Td colspan=3 align=right class=footer_logo valign=middle>ANSWERTHINK&nbsp;&nbsp;&nbsp;</Td>
</Tr>
</Table>
</Div>
<script type="text/javascript">
var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
</script>
<script type="text/javascript">
var pageTracker = _gat._getTracker("UA-1115896-4");
pageTracker._initData();
pageTracker._trackPageview();
</script>
</Body>
</Html>