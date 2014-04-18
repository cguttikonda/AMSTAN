<html>
<head>
<title>American Standard Browser Requirements Check</title>
<%@ include file="ezButtonDir.jsp"%>
<script language="JavaScript">
<!--
	var jsVer = "1.0";
//-->
</script>

<script language="JavaScript1.1">
<!--
		jsVer = "1.1";
//-->
</script>

<script language="JavaScript1.2" type="text/javascript">
<!--
	jsVer = "1.2";
	var jvmStandard = new Array(1,5,0,0);
	function getCookie(c_name)
	{
		if (document.cookie.length>0)
		{
			c_start=document.cookie.indexOf(c_name + "=");
			if (c_start!=-1)
			{
				c_start	=	c_start + c_name.length+1;
				c_end	=	document.cookie.indexOf(";",c_start);
				if (c_end == -1)
					c_end=document.cookie.length;
				return unescape(document.cookie.substring(c_start,c_end));
			}
		}
		return "";
	}

	function setCookie(c_name,value)
	{
		document.cookie=c_name+ "=" +escape(value);
	}

	function onLoad()
	{
		document.all['javascriptDisabled'].innerHTML = '';
		document.all['javascriptEnabled'].innerHTML = 'Verified OK (JavaScript '+jsVer+' enabled)';
		if (navigator.javaEnabled())
		{
			document.all['javaDisabled'].innerHTML = '';
			document.all['javaEnabled'].innerHTML  = 'Verified OK (JVM enabled)';
			setTimeout("setJavaVendorVersion()", 500);
		}
		var isCookieEnabled = window.navigator.cookieEnabled;
		if (isCookieEnabled)
		{
			Delete_Cookie('ASTTestCookie');
			if (Get_Cookie('ASTTestCookie')!=null)
			{
				isCookieEnabled = false;
			}
		}
		if (isCookieEnabled)
		{
			storeRFCLTestCookie();
			if (Get_Cookie('RFCLTestCookie') == null)
			{
				isCookieEnabled = false;
			}
		}

		if (isCookieEnabled)
		{
			document.all['cookieDisabled'].innerHTML = '';
			document.all['cookieEnabled'].innerHTML = 'Verified OK (allowed)';
		}
		testPopup();
	}

	function testPopup()
	{
		var popuptest = window.open("123.htm", "test","width=100,height=100,top=0,menubar=no,toolbar=no,directories=no,location=no,resizable=no,scrollbars=no,status=no");
		if(popuptest != null)
		{
			try
			{
				popuptest.blur();
				popupDone(true);
			}
			catch (e)
			{
				popupDone(false);
			}
			window.focus();
			popuptest.close();
		}
		else
		{
			popupDone(false);
		}
		
	}

	var javaCheckDone = false;
	function setJavaVendorVersion()
	{
		
		onerror 		= errorHandlerEatIt;
		var jvmVersionOk 	= false;
		var jvmVersion 		= "";
		var jvmVendor 		= "";
		var retrievedVersions 	= true;
		try
		{
			jvmVersion = ezcheckapplet.getJavaVersion();
			jvmVendor  = ezcheckapplet.getJavaVendor();
		}
		catch(e)
		{
			retrievedVersions = false;
		}

		if (jvmVendor.indexOf("Sun") >= 0)
		{
			var jvmVersionDetail = jvmVersion.split(".");
			
			var finishCompare = false;
			jvmVersionOk = true;
			for (var i = 0; i < jvmVersionDetail.length; i++)
			{
				if (finishCompare)
				{
					break;
				}
				var jvmVersionDetailSpecific = jvmVersionDetail[i].split("_");
				for (var j = 0; j < jvmVersionDetailSpecific.length; j++)
				{
					var versionNumber = parseInt(jvmVersionDetailSpecific[j], 10);
					if (versionNumber > jvmStandard[i+j])
					{
						finishCompare = true;
					}
					else if (versionNumber < jvmStandard[i+j])
					{
						jvmVersionOk = false;
						finishCompare = true;
					}
				}
			}
		}
		if (jvmVersionOk)
		{
			document.all['javaDisabled'].innerHTML = '';
			document.all['javaEnabled'].innerHTML = 'Verified OK (' + jvmVendor + ' JVM ' + jvmVersion + ' enabled)';
		}
		else
		{
			var upgradeMessage = "";
			if (retrievedVersions)
			{
				upgradeMessage += jvmVendor + " JVM <b>" + jvmVersion + "</b> detected<br>";
			}
			//upgradeMessage += "Update your version of Java to take advantage of the latest RFCL Portal features:<br>";
			upgradeMessage += "<a href = 'http://www.java.com/getjava/' target='_blank'>http://www.java.com/getjava/</a><br>";

			document.all['javaDisabled'].innerHTML = upgradeMessage;
			document.all['javaEnabled'].innerHTML = '';
			showErrors();
			isOK = false;
		}
		onerror = null;
		javaCheckDone = true;
	}

	function errorHandlerEatIt()
	{
		return true;
	}

	function errorHandler()
	{
		onerror = null;
		testPopup();
		return true;
	}

	function sanityComplete()
	{
		var javaVersion = "";
		var osVersion = "";
		try
		{
			javaVersion = checkApplet.getJavaVersion();
		}
		catch(e)
		{
			javaVersion = "failed";
		}
		try
		{
			osVersion = checkApplet.getOsVersion();
		}
		catch(e)
		{
			osVersion = "failed";
		}
		location.href = "/bidder/check_complete.do?projectId=null&cachePath="+testedCachePath+"&javaVersion="+javaVersion+"&osVersion="+osVersion ;
	}

	function popupDone(isPopupDone)
	{
		if(isPopupDone)
		{
			document.all['popupsDisabled'].innerHTML = '';
			document.all['popupsEnabled'].innerHTML = 'Verified OK (allowed)';
		}	
		else
		{
			document.all['popupsDisabled'].innerHTML = 'Popups blocked';
			document.all['popupsEnabled'].innerHTML = '';
		}
	}


	function Get_Cookie(name)
	{
		var start = document.cookie.indexOf(name+"=");
		var len = start+name.length+1;
		if ((!start) && (name != document.cookie.substring(0,name.length)))
			return null;
		if (start == -1)
			return null;
		var end = document.cookie.indexOf(";",len);
		if (end == -1)
			end = document.cookie.length;
		return unescape(document.cookie.substring(len,end));
	}

	function Set_Cookie(name,value,expires,path,domain,secure)
	{
		document.cookie = name + "=" +escape(value) +
		( (expires) ? ";expires=" + expires.toGMTString() : "") +
		( (path) ? ";path=" + path : "") +
		( (domain) ? ";domain=" + domain : "") +
		( (secure) ? ";secure" : "");
	}

	function Delete_Cookie(name,path,domain)
	{
		if (Get_Cookie(name)) document.cookie = name + "=" +
		( (path) ? ";path=" + path : "") +
		( (domain) ? ";domain=" + domain : "") +
		";expires=Thu, 01-Jan-1970 00:00:01 GMT";
	}
	var today = new Date();
	var zero_date = new Date(0,0,0);
	today.setTime(today.getTime() - zero_date.getTime());

	var todays_date = new Date(today.getYear(),today.getMonth(),today.getDate(),0,0,0);
	var expires_date = new Date(todays_date.getTime() + (8 * 7 * 86400000));

	function storeRFCLTestCookie()
	{
		if (!Get_Cookie('RFCLTestCookie'))
		Set_Cookie('RFCLTestCookie','RFCLTestCookie');
	}

	function storeIntelligentCookie(name,value)
	{
		if (Get_Cookie('RFCLTestCookie'))
		{
			var IntelligentCookie = Get_Cookie(name);
			if ((!IntelligentCookie) || (IntelligentCookie != value))
			{
				Set_Cookie(name,value,expires_date);
				var IntelligentCookie = Get_Cookie(name);
				if ((!IntelligentCookie) || (IntelligentCookie != value))
					Delete_Cookie('RFCLTestCookie');
			}
		}
	}
	function checkPDF()
	{
		var isInstalled = false;
		var version = null;
		if (window.ActiveXObject) 
		{
		    var control = null;
		    try 
		    {
			control = new ActiveXObject('AcroPDF.PDF');
		    } catch (e) {}
		    if (!control) 
		    {
			try {
			    control = new ActiveXObject('PDF.PdfCtrl');
			} catch (e) {return;}
		    }
		    if (control) 
		    {
			isInstalled = true;
		    }
		}
		if(isInstalled)
		{
			document.all['adobeDisabled'].innerHTML = '';
			document.all['adobeEnabled'].innerHTML = 'Verified OK (allowed)';
		}
		else
		{
			document.all['adobeDisabled'].innerHTML = "Plugin for ADOBE Reader not installed. Please download the ADOBE reader by clicking <a href='http://www.adobe.com/products/acrobat/readstep2.html' target='_new' style='text-decoration:none;color:blue'>here</a>";
			document.all['adobeEnabled'].innerHTML = '';
		}
	}
//-->
</script>

<script language="JavaScript1.3"><!--jsVer = "1.3";//--></script>
<script language="JavaScript1.4"><!--jsVer = "1.4";//--></script>
<script language="JavaScript1.5"><!--jsVer = "1.5";//--></script>
<script language="JavaScript1.6"><!--jsVer = "1.6";//--></script>
<script language="JavaScript1.7"><!--jsVer = "1.7";//--></script>
<script language="JavaScript1.8"><!--jsVer = "1.8";//--></script>
<script language="JavaScript1.9"><!--jsVer = "1.9";//--></script>
<script language="JavaScript2.0"><!--jsVer = "2.0";//--></script>
<script language="JavaScript2.1"><!--jsVer = "2.1";//--></script>
<script language="JavaScript2.2"><!--jsVer = "2.2";//--></script>
<script language="JavaScript2.3"><!--jsVer = "2.3";//--></script>

<style>
	a, a:link, a:visited, a:hover, a:active
	{
		text-decoration: underline;
		color: blue
	}
	.error
	{
		color:ff0000;
	}
	.message
	{
		color:0000ff;
	}
</style>
</head>

<body onload="onLoad();checkPDF();checkBrowser()" scroll=no>


<Div id='inputDiv' style='position:relative;align:center;top:1%;width:100%;height:15%'>
<Table width="95%" border="0" cellspacing="0" cellpadding="0" align=center valign=center>
<Tr>
	<Td height="5" style="background-color:'F3F3F3'" width="5" background="/CRI/EzCommerce/EzCommon/Images/Table_Corners/Cb_c1.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"></Td>
	<Td height="5" style="background-color:'F3F3F3'" background="/CRI/EzCommerce/EzCommon/Images/Table_Corners/Cb_e1.gif"><img width="1" height="5" src="/CRI/EzCommerce/EzCommon/Images/Table_Corners/Cb_e1.gif"></Td>
	<Td height="5" style="background-color:'F3F3F3'" width="5" background="/CRI/EzCommerce/EzCommon/Images/Table_Corners/Cb_c2.gif"><img height="5" width="5" src="/CRI/EzCommerce/EzCommon/Images/Table_Corners/Cb_c2.gif"></Td>
</Tr>
<Tr >
	<Td width="5" style="background-color:'F3F3F3'" background="/CRI/EzCommerce/EzCommon/Images/Table_Corners/Cb_e2.gif"><img width="5" height="1" src="/CRI/EzCommerce/EzCommon/Images/Table_Corners/Cb_e2.gif"></Td>
	<Td style="background-color:'F3F3F3'" valign=middle align=center>
		<table border="0" cellpadding="0" cellspacing="10" width="100%">
		<tr>
			<td style="background-color:'F3F3F3'">
				<h3>Browser Requirements</h3>
				<p><b>Your web browser configuration has been checked for minimum requirements necessary to use CRI Portal.</b></p>
				<p>If any one of the following checks has NOT passed, show this page to your network administrator.</p>
			</td>
		</tr>
		<tr>
			<td style="background-color:'F3F3F3'">
				<h4>System Requirements</h4>
				<ol>
					<li>Microsoft Windows with Internet Explorer 5.5 or later<br>
						<span class="message">
							Verified OK (MSIE 6.0)
						</span>
					</li>
					<li>
						Javascript 1.2 or later must be enabled<br>
						<span id="javascriptEnabled" class="message"></span>
						<span id="javascriptDisabled" class="error">
							<script language="JavaScript"><!--document.write("<b>JavaScript " + jsVer + " enabled.</b>")//--></script>
							<noscript>
								<b>Your browser does not currently support JavaScript.</b>
							</noscript>
								This failure ALWAYS causes other failures below.
								This setting is changed on the &quot;Security&quot; tab
								found by selecting the &quot;Internet Options...&quot; menu item
								on this browser's &quot;Tools&quot; menu.
						</span>
					</li>
					<li>
						Java must be enabled (Sun JVM
						<script>
							var finalPoint = jvmStandard[3];
							if (finalPoint < 10)
							{
								finalPoint = "0" + finalPoint;
							}
							document.write(jvmStandard[0] + "." + jvmStandard[1] + "." + jvmStandard[2] + "_" + finalPoint);
						</script>
						or newer required)<br>
						<span id="javaEnabled" class="message"></span>
						<span id="javaDisabled" class="error">
							Java Disabled.
							This setting is changed on the &quot;Security&quot; tab
							found by selecting the &quot;Internet Options...&quot; menu item
							on this browser's &quot;Tools&quot; menu.
						</span>
						<br>
					</li>

					<li>
						Cookies must be allowed<br>
						<span id="cookieEnabled" class="message"></span>
						<span id="cookieDisabled" class="error">
							Cookies Disabled.
						</span>
					</li>

					<li>
						Popup windows must be allowed<br>
						<span id="popupsEnabled" class="message"></span>
						<span id="popupsDisabled" class="error">
							Popups blocked.
						</span>
					</li>
					<li>
						ADOBE Reader must be installed<br>
						<span id="adobeEnabled" class="message"></span>
						<span id="adobeDisabled" class="error">

						</span>
					</li>
				</ol>

				<h4>Recommended</h4>
				<ol>
					<li>128Kbs or greater network connection</li>
					<li>Minimum screen resolution of 1024x768 (recommended)</li>
				</ol>

				<h4>Security Features</h4>
				<ol>
					<li>No ActiveX is used</li>
					<li>Java applets are signed by CRI.</li>
					<li>No software is installed on the user's computer</li>
					
				</ol>

			</td>
		</tr>
		</table>
	</Td>
	<Td width="5" style="background-color:'F3F3F3'" background="/CRI/EzCommerce/EzCommon/Images/Table_Corners/Cb_e3.gif"><img width="5" height="1" src="Cb_e3.gif"></Td>
</Tr>
<Tr>
	<Td width="5" style="background-color:'F3F3F3'" height="5" background="/CRI/EzCommerce/EzCommon/Images/Table_Corners/Cb_c3.gif"><img width="5" height="5" src="/CRI/EzCommerce/EzCommon/Images/Table_Corners/Cb_c3.gif"></Td>
	<Td height="5" style="background-color:'F3F3F3'" background="/CRI/EzCommerce/EzCommon/Images/Table_Corners/Cb_e4.gif"><img width="1" height="5" src="/CRI/EzCommerce/EzCommon/Images/Table_Corners/Cb_e4.gif"></Td>
	<Td width="5" style="background-color:'F3F3F3'" height="5" background="/CRI/EzCommerce/EzCommon/Images/Table_Corners/Cb_c4.gif"><img width="5" height="5" src="/CRI/EzCommerce/EzCommon/Images/Table_Corners/Cb_c4.gif"></Td>
</Tr>
</Table>
</Div>	




<table>
<tr>
	<td valign="top">
		<applet code="EzCheckBrowserApplet.class" name="ezcheckapplet" archive="../jars/ezapplet.jar" width="1" height="1"></applet>
	</td>
</tr>
</table>

<center>
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	buttonName.add("Close");
	buttonMethod.add("self.close()");
	out.println(getButtonStr(buttonName,buttonMethod));  
%>
</center>

</body>
</html>
