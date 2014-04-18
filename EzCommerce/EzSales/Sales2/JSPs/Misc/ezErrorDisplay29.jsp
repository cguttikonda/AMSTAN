<%@ page language="java" isErrorPage="true"%>
<%@ page import = "ezc.ezcommon.EzJSPExceptionHandler" %>
<%@ include file="../../../Includes/JSPs/Lables/iErrorDisplay_Lables.jsp"%>
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />

<html>
<head>
<script> 
	function logOut()
	{
		top.location.href="../../../Sales2/JSPs/Misc/ezLogout.jsp" ;
		
	}	
</script> 
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);

	session.putValue("beingUsed","N");
	log4j.log("session.sessionsessionisNew()   "+session.isNew()+"","W");
	if(session.isNew())
	{
		session.invalidate();
%>		</head>
			<body align="center">
			<br><br><br>
			<center>
				<font face="arial" color="#006666" size="+1">
					&nbsp;<%=loginAgain_L%>&nbsp;<a href="/" onMouseOver="window.status='Click here to re-login.';return true;" onMouseOut="window.status='';return true;" target="_top">login</a> again.
				</font>
			</center>
			</body>
		</html>	
<%		return;
	}
	else
	{
%>		</head>
		<body>
<%		String errorMessage = null;
		Exception e = (Exception)request.getAttribute("javax.servlet.jsp.jspException");
		EzJSPExceptionHandler exHandler1 = new EzJSPExceptionHandler();
		Object ss1=exHandler1.handleException(e);
		if(e.getClass() == ezc.ezutil.EzJspException.class)
		{
			ezc.ezparam.ReturnObjFromRetrieve retEx = (ezc.ezparam.ReturnObjFromRetrieve)((ezc.ezutil.EzJspException)e).getReturnObject();
			if(retEx != null)
			{
				String[] errMessages = retEx.getErrorMessages();
				int errCount = errMessages.length;
				for (int i=0;i<errCount;i++)
				{
		 			String eMsg = errMessages[i];
					int index=eMsg.indexOf("Ezc");
					if(eMsg.indexOf("No Connection Manager Available ") != -1)
					{
						errorMessage = serviceNotAvailable_L;
					}
					else if(eMsg.indexOf("Not Authorized") != -1)
					{
						errorMessage = notAuthToView_L;
					}
					else if(eMsg.indexOf("java.lang.Object") != -1)
					{
						errorMessage = serviceTempoUnAvailable_L;
					}
					else
					{
						errorMessage = serverBusy_L;
					}
					break;
				}
			}
		}
		else
		{
			errorMessage = serverBusyTAgain_L;
		}
%>
		
		
		<Div id='inputDiv' style='position:relative;align:center;top:10%;width:100%;height:100%'>
		<Table width="80%" border="0" cellspacing="0" cellpadding="0" align=center valign=center>
		<Tr>
			<Td height="5" style="background-color:'#F3F3F3'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"></Td>
			<Td height="5" style="background-color:'#F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"></Td>
			<Td height="5" style="background-color:'#F3F3F3'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"></Td>
		</Tr>
		<Tr height=300px>
			<Td width="5" style="background-color:'#F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"><img width="5" height="1" src="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"></Td>
			<Td style="background-color:'#F3F3F3'" valign=middle>
				<Table align=center border="0" cellpadding="0" cellspacing="0" width="80%" style="background:#F3F3F3">
					<Tr>
						<Td align='center' style="background:#F3F3F3" width=50%><img border=0 src="../../Images/sbusy.gif" ></Td>
						<Td align='center' style="background:#F3F3F3" width=50%><font color="00355D"><b><%=errorMessage%><br>*Please click here to <a href="JavaScript:logOut()">login</a> again</b></font></Td>
					</Tr>
				</Table>
			</Td>
			<Td width="5" style="background-color:'#F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e3.gif"><img width="5" height="1" src="Cb_e3.gif"></Td>
		</Tr>
		<Tr>
			<Td width="5" style="background-color:'#F3F3F3'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"></Td>
			<Td height="5" style="background-color:'#F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"></Td>
			<Td width="5" style="background-color:'#F3F3F3'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"></Td>
		</Tr>
		</Table>
		</Div>
	
		<Div id="MenuSol"></Div>
	</body>
</html>
<%	
	}
%>
