<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iLogout_Lables.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iUpdateWebStats.jsp"%>
<html>
<head>
<title>Thanks for Accessing American Standard Web Portal</title>
<%
		String autoLogout = request.getParameter("AUTOLOGOUT");

	if(!"Y".equals(autoLogout))
	{
%>
		<meta http-equiv="refresh" content="2;url=/AST">
<%
	}
%>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
</head>

<%
	
	try{ Session.logOut();session.invalidate();} catch(Exception e) { System.out.println("Exception while logout");} 
%>
<body bgcolor="#FFFFF7" onunload="history.forward()" scroll=no>
<Div id='inputDiv' style='position:relative;align:center;top:10%;width:100%;height:100%'>
<Table width="60%" height="20%" border="0" cellspacing="0" cellpadding="0" align=center valign=center>
<Tr>
	<Td height="5" style="background-color:'F3F3F3'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"></Td>
	<Td height="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"></Td>
	<Td height="5" style="background-color:'F3F3F3'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"></Td>
</Tr>
<Tr>
	<Td width="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"><img width="5" height="1" src="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"></Td>
	<Td style="background-color:'F3F3F3'" valign=middle>
		<Table border="0" align="center" valign=middle width="100%" cellpadding=10 cellspacing=10 class=welcomecell>
		<Tr> 
			<Td style="background-color:'F3F3F3'" valign=middle align=center>
				<font size="4">
<%
				if(!"Y".equals(autoLogout))
				{
%>
					You have been successfully logged out
					<br><br>
					<font size="1">
					You will be taken to the login page in few seconds.<br><br> If your 
					browser doesn't support the refresh tag click <b><a href="/AST">here</a></b>
					to go to Login Page</font>
<%
				}
				else
				{
%>
					<font size="1" face="tahoma"><b>Maximum idle time exceeded<BR><BR>Logging out automatically<BR><BR>Click <a href='/'>here</a> to login again</b></font>
<%
				}
%>				
					
				</font>
			</Td>
		</Tr>
		</Table>
	</Td>
	<Td width="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e3.gif"><img width="5" height="1" src="Cb_e3.gif"></Td>
</Tr>
<Tr>
	<Td width="5" style="background-color:'F3F3F3'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"></Td>
	<Td height="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"></Td>
	<Td width="5" style="background-color:'F3F3F3'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"></Td>
</Tr>
</Table>
</Div>
<Div id="MenuSol"></Div>
</body>
</html>
